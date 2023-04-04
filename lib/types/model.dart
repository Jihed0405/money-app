import 'package:flutter_money_app/extensions/date_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter_money_app/extensions/expenses_extensions.dart';
import '../data/data_state_notifier.dart';
import '../data/transaction.dart';
import '../utils/constants.dart';
class MyModel{
  
Future fetchData(ref) async{
   if(ref.watch(transactionProvider).length==0){
  try {
    http.Response response = await http.get(uri);
    var data = json.decode(response.body);
    data.forEach((transaction){
      var type =transaction['type']=="O"?TransactionType.outflow:TransactionType.inflow;
Transaction t =Transaction(transaction['id'],
              transaction['categoryType'],
              type,transaction['itemCategoryName'],
              transaction['itemName'],
              double.parse (transaction['amount']),
               DateTime.parse(transaction['date'])
              ) ;
               ref
          .read(transactionProvider.notifier)
          .state.add(t);
         
    });
    //data=json.decode(data);
 
  } catch (e) {
    print("error is $e ");
  }};
}
void postData(Transaction data,ref)async{
  var liste = [];
  var type =data.transactionType==TransactionType.outflow
  ?"O":"I";
  try {
    http.Response response=await http.post(uri,
     headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "categoryType": data.categoryType,
      "type":type,
       "itemCategoryName": data.itemCategoryName,
        "itemName": data.itemName,
        "amount": data.amount,
        "date": data.date.toIso8601String()
    }),
    );
    if(response.statusCode==201){
     
    ref.invalidate(transactionProvider);
    }
    else{
      print("something goes wrong when creating new data");
    }
  } catch (e) {
    print("Error is $e");
    
  }
}

void editData(Transaction data,ref)async{
  var liste = [];
  var type =data.transactionType==TransactionType.outflow
  ?"O":"I";
  var specificUrl = url +"/"+ref.watch(currentTransactionToEdit).id;
  try {
    http.Response response=await http.put(uri.pspecificUrl.pa,
     headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "categoryType": data.categoryType,
      "type":type,
       "itemCategoryName": data.itemCategoryName,
        "itemName": data.itemName,
        "amount": data.amount,
        "date": data.date.toIso8601String()
    }),
    );
    if(response.statusCode==200){
     
    ref.invalidate(transactionProvider);
    }
    else{
      print("something goes wrong when editing new data");
    }
  } catch (e) {
    print("Error is $e");
    
  }
}


}