import 'package:flutter/material.dart';
import 'package:flutter_money_app/data/expense.dart';
import 'package:flutter_money_app/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/data_state_notifier.dart';

class IncomeWidget extends ConsumerWidget {
  final ExpenseData expenseData;
  IncomeWidget({Key? key,required this.expenseData}) : super(key: key);
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    
    return InkWell(onTap:() {
                   if(expenseData.label == "Income") {
                    ref.read(allTransactions.notifier).state=false;
                     ref.read(incomeType.notifier).state=true;
                     ref.read(outcomeType.notifier).state=false;
                   } else {
                    ref.read(allTransactions.notifier).state=false;
                     ref.read(outcomeType.notifier).state=true;
                     ref.read(incomeType.notifier).state=false;
                   }
                  },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset.zero,
                  spreadRadius: 3,
                  blurRadius: 12)
            ],
            color: expenseData.label == "Income" ? primaryDark : accent,
            borderRadius:
                const BorderRadius.all(Radius.circular(defaultRadius))),
        child: Padding(
          padding: const EdgeInsets.all(defaultSpacing / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(defaultSpacing / 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          expenseData.label,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: defaultSpacing / 4),
                        child: FittedBox(
                          child: Text(expenseData.amount,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ImageIcon(
                expenseData.icon,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
