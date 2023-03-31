import 'package:flutter/material.dart';
import 'package:flutter_money_app/data/data_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/transaction.dart';
import '../data/user_info.dart';
import '../utils/constants.dart';
import '../widget/chart_widget.dart';
import '../widget/transaction_widget.dart';

const List<String> _listFilter = <String>[
  'Day',
  'Week',
  'Month',
];
const List<String> _listCategory = <String>[
  'All',
  'Fashion',
  'Grocery',
  'Transport',
  'Entertainment',
  'Travel',
  'Home Rent',
  'Pet',
  "Investments",
  'Extra',
  'Payments',
  "Selling something",
  'Salary',
  'Commission',
  'Interest',
  "Gifts",
  "Government Payments"
];

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  int _selectedIndex = 0;
  int _selectedCategoryIndex = 0;
  _onSelected(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _onSelectedCategory(index) {
    setState(() {
      _selectedIndex = index;
    });
    print(index);
  }

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(defaultSpacing),
        child: SafeArea(
          left: true,
          right: true,
          bottom: true,
          top: true,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  centerTitle: true,
                  title: Text(
                    "Expenses",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  elevation: 0,
                  backgroundColor: background,
                  leading: const Icon(
                    Icons.arrow_back_ios,
                    color: fontDark,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          horizontal: defaultSpacing),
                      width: 3 * defaultWidth / 5,
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) => Container(
                          width: defaultWidth / 3,
                          height: 20,
                          color: Colors.transparent,
                          child: ListTile(
                            title: Container(
                              height: 40,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(defaultRadius * 2)),
                                  color: background),
                              child: Center(
                                child: Text(
                                  _listFilter[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: _selectedIndex != null &&
                                                  _selectedIndex == index
                                              ? Colors.blue[300]
                                              : fontSubHeading,
                                          fontSize: fontSizeBody),
                                ),
                              ),
                            ),
                            onTap: () => _onSelected(index),
                          ),
                        ),
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.black,
                    )
                  ],
                ),
                const SizedBox(
                  height: defaultSpacing * 2,
                ),
                Consumer(builder: (context, ref, child) {
                  final List<Transaction> transactionList =
                      ref.watch(transactionProvider);
                  return LineChartWidget(transactionList);
                }),
                const SizedBox(
                  height: defaultSpacing * 2,
                ),
                Container(
                  child: Text(
                    "Detail Transactions",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: defaultSpacing,
                ),
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: defaultWidth * 0.9,
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: ListView.builder(
                        itemCount: 17,
                        itemBuilder: (context, index) => Container(
                          width: defaultWidth / 2.8,
                          height: 80,
                          color: Colors.transparent,
                          child: ListTile(
                            title: Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: background),
                              child: Center(
                                child: Text(
                                  _listCategory[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color:
                                              _selectedCategoryIndex != null &&
                                                      _selectedIndex == index
                                                  ? Colors.blue[300]
                                                  : fontSubHeading,
                                          fontSize: fontSizeBody),
                                ),
                              ),
                            ),
                            onTap: () => _onSelectedCategory(index),
                          ),
                        ),
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: defaultSpacing,
                ),
                ...userData.transactions.map((transaction) =>
                    TransactionWidget(transaction: transaction)),
                const SizedBox(
                  height: defaultSpacing,
                ),
              ]),
        ),
      ),
    );
  }
}
