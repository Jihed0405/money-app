import 'package:flutter/material.dart';
import 'package:flutter_money_app/data/expense.dart';
import 'package:flutter_money_app/utils/constants.dart';
import '../data/data_state_notifier.dart';
import '../data/transaction.dart';
import '../data/user_info.dart';
import '../widget/income_widget.dart';
import '../widget/transaction_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  Home({Key? key}) : super(key: key);
  var listeVisible;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Transaction> transactionList = ref.watch(transactionProvider);
     
    return SingleChildScrollView(
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
            Center(
              child: Column(children: [
                Text(
                  "\$ ${userData.totalBalance}",
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
            const SizedBox(
              height: defaultSpacing * 2,
            ),
            Row(
              children: [
                Expanded(
                    child: IncomeWidget(
                  expenseData: ExpenseData("Income", "\$ ${userData.inflow}",
                      const AssetImage('assets/icons/trend.png')),
                )),
                const SizedBox(
                  width: defaultSpacing,
                ),
                Expanded(
                    child: IncomeWidget(
                  expenseData: ExpenseData("Expense", "-\$ ${userData.outflow}",
                      const AssetImage('assets/icons/down.png')),
                )),
              ],
            ),
            const SizedBox(
              height: defaultSpacing * 2,
            ),
            Text(
              "Recent Transactions",
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
            ...transactionList.map(
                (transaction) => TransactionWidget(transaction: transaction)),
            const SizedBox(
              height: defaultSpacing,
            ),
            const Text(
              "Yesterday",
              style: TextStyle(color: fontSubHeading),
            ),
            ...transaction2.map(
                (transaction) => TransactionWidget(transaction: transaction)),
          ],
        ),
      ),
    );
  }
}
