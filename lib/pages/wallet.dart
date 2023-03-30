import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_money_app/pages/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/data_state_notifier.dart';
import '../data/transaction.dart';
import '../widget/transaction_widget.dart';

class Wallet extends ConsumerWidget{

   const Wallet({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final List<Transaction> transactionList = ref.watch(transactionProvider); 
    return Column(
      
    );
  }

}