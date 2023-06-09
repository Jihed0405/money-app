import 'package:flutter/material.dart';
import 'package:flutter_money_app/data/expense.dart';
import 'package:flutter_money_app/extensions/date_extensions.dart';
import 'package:flutter_money_app/extensions/expenses_extensions.dart';
import 'package:flutter_money_app/utils/constants.dart';
import '../data/data_state_notifier.dart';
import '../data/transaction.dart';
import '../data/user_info.dart';
import '../types/model.dart';
import '../widget/income_widget.dart';
import '../widget/transaction_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
class Home extends ConsumerWidget {
  Home({Key? key}) : super(key: key);
  var listeVisible;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
var list =ref.watch(transactionProvider);

  

  final myModel= MyModel();
  return FutureBuilder(
    future: myModel.fetchData(ref),
    
    builder: (BuildContext context, AsyncSnapshot snapshot) {
     
     return Scaffold(
      backgroundColor: background,
       body: SafeArea(
        top: true,
     
         child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: defaultSpacing * 4,
                ),
                ListTile(
                  title: Text('Hey, ${userData.firstName}!'),
                  leading: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(defaultRadius)),
                      child: Image.asset("assets/images/avatar.jpg")),
                  trailing: Image.asset("assets/icons/bell.png"),
                ),
                const SizedBox(
                  height: defaultSpacing,
                ),
                InkWell(onTap:() {
                      ref.read(allTransactions.notifier).state=true;
                       ref.read(incomeType.notifier).state=false;
                       ref.read(outcomeType.notifier).state=false;},
                  child: Container(
                    color: background,
                    child: Center(
                      child: Column(children: [
                        Text(
                          "\$ ${formatNumber(ref.watch(transactionProvider).sumIncome()-ref.watch(transactionProvider).sumExpense())}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 28, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: defaultSpacing / 2,
                        ),
                        Text(
                          "Total balance",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: fontSubHeading),
                        )
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: defaultSpacing * 2,
                ),
                Row(
                  children: [
                    Expanded(
                        child: IncomeWidget(
                      expenseData: ExpenseData("Income", "\$ ${formatNumber(ref.watch(transactionProvider).sumIncome())}",
                          const AssetImage('assets/icons/trend.png')),
                    )),
                    const SizedBox(
                      width: defaultSpacing,
                    ),
                    Expanded(
                        child: IncomeWidget(
                      expenseData: ExpenseData("Expense", "-\$ ${formatNumber(ref.watch(transactionProvider).sumExpense())}",
                          const AssetImage('assets/icons/down.png')),
                    )),
                  ],
                ),
                const SizedBox(
                  height: defaultSpacing * 2,
                ),
               if(!(ref.watch(incomeType)||ref.watch(outcomeType))&&!ref.watch(allTransactions)) Text(
                  "Recent Transactions",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                
               if(ref.watch(outcomeType)) Text(
                  "All Expenses Transactions",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                 if(ref.watch(incomeType)) Text(
                  "All Income Transactions",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                 if(ref.watch(allTransactions)) Text(
                  "All Transactions",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                
                const SizedBox(
                  height: defaultSpacing,
                ),
                if(!(ref.watch(incomeType)||ref.watch(outcomeType))&&!ref.watch(allTransactions)) ...[const Text(
                  "Today",
                  style: TextStyle(color: fontSubHeading),
                ),
                const SizedBox(
                  height: defaultSpacing,
                ),
              if(ref.watch(todayTransactions).isEmpty)
                const Center(
                child: Text("no data found"),
              ),
                ...ref.watch(todayTransactions).map(
                    (transaction) =>TransactionWidget(transaction: transaction)),
                const SizedBox(
                  height: defaultSpacing,
                ),
                const Text(
                  "Yesterday",
                  style: TextStyle(color: fontSubHeading),
                ) ,
                 const SizedBox(
                  height: defaultSpacing,
                ),
              if(ref.watch(yesterdayTransactions).isEmpty)
                const Center(
                child: Text("no data found"),
              ),
                  ...ref.watch(yesterdayTransactions).map(
                   (transaction) =>TransactionWidget(transaction: transaction)),
              ],
              if(ref.watch(incomeType)) ...[
                const SizedBox(
                  height: defaultSpacing,
                ),
              if(ref.watch(incomeTransactions).isEmpty)
                const Center(
                child: Text("no data found"),
              ),
                ...ref.watch(incomeTransactions).map(
                    (transaction) =>TransactionWidget(transaction: transaction)),],
                     if(ref.watch(outcomeType)) ...[
                const SizedBox(
                  height: defaultSpacing,
                ),
              if(ref.watch(expensesTransactions).isEmpty)
                const Center(
                child: Text("no data found"),
              ),
                ...ref.watch(expensesTransactions).map(
                    (transaction) =>TransactionWidget(transaction: transaction)),],
                      if(ref.watch(allTransactions)) ...[
                const SizedBox(
                  height: defaultSpacing,
                ),
              if(ref.watch(transactionProvider).isEmpty)
                const Center(
                child: Text("no data found"),
              ),
                ...ref.watch(allTransactionsProviders).map(
                    (transaction) =>TransactionWidget(transaction: transaction)),],
              ],
            ),
          ),
           ),
       ),
     );     
    },
  );
   
  }
}
