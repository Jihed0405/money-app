import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_money_app/pages/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../data/data_state_notifier.dart';
import '../data/transaction.dart';
import '../utils/constants.dart';
import '../widget/transaction_widget.dart';

List<Transaction> myList = [];

class Wallet extends ConsumerWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Transaction> transactionList = ref.watch(transactionProvider);

    return Container();
  }
}
