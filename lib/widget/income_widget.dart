import 'package:flutter/material.dart';
import 'package:flutter_money_app/data/expense.dart';
import 'package:flutter_money_app/utils/constants.dart';

class IncomeWidget extends StatelessWidget {
  final ExpenseData expenseData;
  const IncomeWidget({super.key, required this.expenseData});

  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
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
                      Text(
                        expenseData.label,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: defaultSpacing / 4),
                        child: Text(expenseData.amount,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
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
