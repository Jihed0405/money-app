import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_money_app/data/transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';


// Book State Notifier
final visibleButtonProvider = StateProvider<bool>((ref) {
  return true ;
});
final selectedPeriodIndex = StateProvider<int>((ref) {
  return 0 ;
});
final selectedCategoryIndex = StateProvider<int>((ref) {
  return 0 ;
});
final numberOfPages = StateProvider<int>((ref) {
  return 1 ;
});
final expenses = StateProvider<List<Transaction>>((ref) {
return [];
}); 
final  startDate = StateProvider<DateTime>((ref){
return DateTime.now();
});
final  endDate = StateProvider<DateTime>((ref){
return DateTime.now();
});
final spentInPeriod= StateProvider<double>((ref) {
  return 0.0;
});
final avgPerDay= StateProvider<double>((ref) {
  return 0.0;
});
final periodIndex = StateProvider<int>((ref) {
  return 1;
});

final currentPage = StateProvider<int>((ref){
return 0;
});
  final  controllerPage = StateProvider((ref) {
  return PageController(initialPage: 0) ;
});
  
  
class DataStateNotifier extends StateNotifier<List<Transaction>> {
  // Zero argument constructor for the super class
  DataStateNotifier() : super(transaction1);

  // Add a Book to the state
  void addTransaction(Transaction transactionToAdd) => state = [...state, transactionToAdd];

  // Remove a Transaction from the state
  void removeBook(Transaction transactionToRemove) => state = [
        for (final transaction in state)
          if (transaction != transactionToRemove) transaction,
      ];
}

// The Transaction Provider
final StateNotifierProvider<DataStateNotifier, List<Transaction>> transactionProvider =
    StateNotifierProvider((ref) => DataStateNotifier());
