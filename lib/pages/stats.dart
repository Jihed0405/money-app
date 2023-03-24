import 'package:flutter/material.dart';

import '../data/user_info.dart';
import '../utils/constants.dart';
import '../widget/transaction_widget.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        
      child:SafeArea(child: Column(
        
        children:[
           AppBar(
          centerTitle: true,
           title:  Text("Expenses",style:Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),),
        elevation: 0,
        backgroundColor: background,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: fontDark,
        ),
      
      ),
      const SizedBox(
              height: defaultSpacing * 2,
            ),
            Text(
              "Detail Transactions",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: defaultSpacing,
            ),
            const Text(
              "Today",
              style: TextStyle(color: fontSubHeading),
            ),
             const SizedBox(
              height: defaultSpacing,
            ),
            ...userData.transactions.map((transaction) =>
            TransactionWidget(transaction:transaction)),
             const SizedBox(
              height: defaultSpacing,
            ),]
      ),
      ),
      
      );
      
    
  }
}