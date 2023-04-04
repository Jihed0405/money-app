import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_money_app/data/transaction.dart';
import 'package:flutter_money_app/extensions/date_extensions.dart';
import 'package:flutter_money_app/extensions/expenses_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

import '../types/model.dart';
import '../types/period.dart';

final selectedDate = StateProvider((ref) {
  return DateTime.now();
});
final dateController = StateProvider<TextEditingController>((ref) {
  return TextEditingController(
      text: '${ref.watch(currentTransactionToEdit).date.formattedDate}');
});
final amountController = StateProvider<TextEditingController>((ref) {
  return TextEditingController(
      text: '${ref.watch(currentTransactionToEdit).amount}');
});
   final noteController = StateProvider<TextEditingController>((ref) {
  return TextEditingController(
      text: ref.watch(currentTransactionToEdit).itemName);
}); 
      final nameController = StateProvider<TextEditingController>((ref) {
  return TextEditingController(
      text: ref.watch(currentTransactionToEdit).itemCategoryName);
}); 
    final transactionType = StateProvider((ref) {
  return TransactionType.inflow;
});
      final itemCategory = StateProvider((ref) {
  return "";
});
     final dropdownValueExpenses = StateProvider((ref) {
  return ref.watch(currentTransactionToEdit).categoryType??" ";
});
  final dropdownValueIncome = StateProvider((ref) {
  return ref.watch(currentTransactionToEdit).categoryType??" ";
});
    final dropdownValueRecurrence = StateProvider((ref) {
  return "None"??" ";
});
  final canSubmit = StateProvider((ref) {
  return false;
});
  
  

final precedentPageIndex = StateProvider<int>((ref) {
  return 0;
});
final currentPageIndex = StateProvider<int>((ref) {
  return 0;
});

final currentTransactionToEdit = StateProvider<Transaction>((ref) {
  return Transaction(
      0, "Entertainment", TransactionType.outflow, "jihed", "en othmen", 0, DateTime.now());
});
final visibleButtonProvider = StateProvider<bool>((ref) {
  return true;
});
final selectedPeriodIndex = StateProvider<int>((ref) {
  return 0;
});
final selectedCategoryIndex = StateProvider<int>((ref) {
  return 0;
});
final isSelectedExpenses = StateProvider((ref) {
  if (ref.watch(currentTransactionToEdit).transactionType ==
      TransactionType.outflow) {
    return <bool>[false, true];
  } else {
    return <bool>[true, false];
  }
});
final isExpenses = StateProvider((ref) {
  if (ref.watch(currentTransactionToEdit).transactionType ==
      TransactionType.outflow) {
    return true;
  } else {
    return false;
  }
});

StateProvider<int> numberOfPages = StateProvider<int>((ref) {
  switch (periods[ref.watch(selectedPeriodIndex)]) {
    // not used
    case Period.week:
      return 53;
    case Period.month:
      return 12;
    case Period.year:
      return 1;
  }
});
final expenses = StateProvider<List<Transaction>>((ref) {
  var filterResults = ref
      .read(transactionProvider.notifier)
      .state
      .filterByPeriod(periods[ref.watch(selectedPeriodIndex)], 0);
  return filterResults[0] as List<Transaction>;
});
final expensesFiltered = StateProvider<List<Transaction>>((ref) {
  var filterResults = ref
      .read(transactionProvider.notifier)
      .state
      .filterByPeriod(periods[ref.watch(selectedPeriodIndex)], 0);
  return filterResults[0] as List<Transaction>;
});
final startDate = StateProvider<DateTime>((ref) {
  var filterResults = ref
      .read(transactionProvider.notifier)
      .state
      .filterByPeriod(periods[ref.watch(selectedPeriodIndex)], 0);
  return filterResults[1] as DateTime;
});
final endDate = StateProvider<DateTime>((ref) {
  var filterResults = ref
      .read(transactionProvider.notifier)
      .state
      .filterByPeriod(periods[ref.watch(selectedPeriodIndex)], 0);

  return filterResults[2] as DateTime;
});
final spentInPeriod = StateProvider<double>((ref) {
  return ref.watch(expenses).sum();
});
final avgPerDay = StateProvider<double>((ref) {
  return ref.watch(spentInPeriod) /
      ref.watch(endDate).difference(ref.watch(startDate)).inDays;
});
final periodIndex = StateProvider<int>((ref) {
  return 1;
});

final currentPage = StateProvider<int>((ref) {
  return 0;
});
final controllerPage = StateProvider((ref) {
  return PageController(initialPage: 0);
});

class DataStateNotifier extends StateNotifier<List<Transaction>> {
  // Zero argument constructor for the super class
  DataStateNotifier() : super([]);

  // Add a Transaction to the state
  void addTransaction(Transaction transactionToAdd) =>
      state = [...state, transactionToAdd];

  // Remove a Transaction from the state
  void removeBook(Transaction transactionToRemove) => state = [
        for (final transaction in state)
          if (transaction != transactionToRemove) transaction,
      ];
}

// The Transaction Provider
final StateNotifierProvider<DataStateNotifier, List<Transaction>>
    transactionProvider = StateNotifierProvider((ref) => DataStateNotifier());
