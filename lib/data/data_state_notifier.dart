import 'package:flutter_money_app/data/transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';


// Book State Notifier
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
