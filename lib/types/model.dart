import 'package:flutter/material.dart';
import 'package:flutter_money_app/extensions/date_extensions.dart';
import 'package:flutter_money_app/types/period.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import '../data/data_state_notifier.dart';
import '../data/transaction.dart';
import '../utils/constants.dart';
import 'package:flutter_money_app/extensions/expenses_extensions.dart';

class MyModel {
  Future fetchData(ref) async {
    if (ref.watch(transactionProvider).length == 0) {
      try {

        http.Response response = await http.get(uri);
        var data = json.decode(response.body);
        data.forEach((transaction) {
          var type = transaction['type'] == "O"
              ? TransactionType.outflow
              : TransactionType.inflow;
          Transaction t = Transaction(
              transaction['id'],
              transaction['categoryType'],
              type,
              transaction['itemCategoryName'],
              transaction['itemName'],
              double.parse(transaction['amount']),
              DateTime.parse(transaction['date']));
        ref.read(transactionProvider.notifier).state.insert(0,t);
        
        });
        //data=json.decode(data);
         var listVerify=ref.watch(transactionProvider);
        developer.log("the value of listVerify is $listVerify");
        var todayTrans = filterToday(ref.watch(transactionProvider));
        var yesterdayTrans = filterYesterday(ref.watch(transactionProvider));
        ref.read(todayTransactions.notifier).state = todayTrans[0];
        ref.read(yesterdayTransactions.notifier).state = yesterdayTrans[0];
        ref.read(expensesTransactions.notifier).state =
            filterExpenses(ref.watch(transactionProvider))[0];
        ref.read(incomeTransactions.notifier).state =
            filterIncome(ref.watch(transactionProvider))[0];
      } catch (e) {
        print("error is $e ");
      }
    }
    ;
  }

  void postData(context, Transaction data, ref) async {
    const snackBarSuccess = SnackBar(
      content: Text('Transaction added successfully!'),
      backgroundColor: Colors.teal,
      behavior: SnackBarBehavior.floating,
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.

    const snackBarError = SnackBar(
      content: Text('Something went wrong try again please!'),
      backgroundColor: Colors.teal,
      behavior: SnackBarBehavior.floating,
    );
    var type = data.transactionType == TransactionType.outflow ? "O" : "I";
    try {
      http.Response response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "categoryType": data.categoryType,
          "type": type,
          "itemCategoryName": data.itemCategoryName,
          "itemName": data.itemName,
          "amount": data.amount,
          "date": data.date.toIso8601String()
        }),
      );
      if (response.statusCode == 201) {
        ref.invalidate(transactionProvider);
      
        ref.read(responseData.notifier).state = true;

        if (ref.watch(responseData)) {
          ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(snackBarError);
        }
      } else {
        ref.read(responseData.notifier).state = false;
        ScaffoldMessenger.of(context).showSnackBar(snackBarError);
      }
    } catch (e) {
      print("Error is $e");
     
      ref.read(responseData.notifier).state = false;
      ScaffoldMessenger.of(context).showSnackBar(snackBarError);
    }
  }

  void editData(context, Transaction data, ref) async {
    const snackBarSuccessEdit = SnackBar(
      content: Text('Transaction edited successfully!'),
      backgroundColor: Colors.teal,
      behavior: SnackBarBehavior.floating,
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.

    const snackBarErrorEdit = SnackBar(
      content: Text('Something went wrong try again please!'),
      backgroundColor: Colors.teal,
      behavior: SnackBarBehavior.floating,
    );

    var type = data.transactionType == TransactionType.outflow ? "O" : "I";

    try {
      var specificUrl = "${url}${ref.watch(currentTransactionToEdit).id}/";
      http.Response response = await http.put(
        Uri.parse(specificUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "categoryType": data.categoryType,
          "type": type,
          "itemCategoryName": data.itemCategoryName,
          "itemName": data.itemName,
          "amount": data.amount,
          "date": data.date.toIso8601String()
        }),
      );
      if (response.statusCode == 200) {
        ref.invalidate(transactionProvider);
        ref.read(responseEditData.notifier).state = true;

       
        if (ref.watch(responseEditData)) {
          ScaffoldMessenger.of(context).showSnackBar(snackBarSuccessEdit);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(snackBarErrorEdit);
        }
      } else {
        print("something goes wrong when editing new data");
        ref.read(responseEditData.notifier).state = false;
        ScaffoldMessenger.of(context).showSnackBar(snackBarErrorEdit);
      }
    } catch (e) {
      print("Error is $e");
      ref.read(responseEditData.notifier).state = false;
      ScaffoldMessenger.of(context).showSnackBar(snackBarErrorEdit);
    }
  }

  void deleteTransaction(ref) async {
    if (ref.watch(currentTransactionToEdit).id != 0) {
      var deleteUrl = "${url}${ref.watch(currentTransactionToEdit).id}/";
      final http.Response response = await http.delete(
        Uri.parse(deleteUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 204) {
        ref.invalidate(transactionProvider);
      } else {
        throw Exception("Failed to delete transaction");
      }
    }
  }

  List filterByPeriod(Period period, int periodIndex, List<Transaction> list) {
    List<Transaction> expenses = [];
    DateTime startDate;
    DateTime endDate;
    DateTime now = DateTime.now();

    switch (period) {
      case Period.week:
        int diffSinceMonday = now.weekday - 1;
        startDate =
            now.subtract(Duration(days: diffSinceMonday + 7 * periodIndex));
        endDate = startDate.add(const Duration(days: 6));
        break;
      case Period.month:
        startDate = DateTime(now.year, now.month - periodIndex, 1);
        endDate = DateTime(now.year, now.month - periodIndex + 1, 0);
        break;
      case Period.year:
        startDate = DateTime(now.year - 1, 1, 1);
        endDate = DateTime(now.year, 12, 31);
        break;
    }

    startDate =
        DateTime(startDate.year, startDate.month, startDate.day, 0, 0, 0);
    endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);

    for (var element in list) {
      if (element.date.isBetween(startDate, endDate) &&
          element.transactionType == TransactionType.outflow) {
        expenses.add(element);
      }
    }

    return [expenses, startDate, endDate];
  }

  List filterToday(List<Transaction> list) {
    List<Transaction> expenses = [];

    for (var element in list) {
      if (element.date.isToday()) {
        expenses.add(element);
      }
    }
    return [expenses];
  }

  List filterYesterday(List<Transaction> list) {
    List<Transaction> expenses = [];

    for (var element in list) {
      if (element.date.isYesterday()) {
        expenses.add(element);
      }
    }
    return [expenses];
  }

  List filterExpenses(List<Transaction> list) {
    List<Transaction> expenses = [];

    for (var element in list) {
      if (element.transactionType == TransactionType.outflow) {
        expenses.add(element);
      }
    }
    return [expenses];
  }

  List filterIncome(List<Transaction> list) {
    List<Transaction> incomes = [];

    list.forEach((element) {
      if (element.transactionType == TransactionType.inflow) {
        incomes.add(element);
      }
    });
    return [incomes];
  }
}
