import 'package:flutter/material.dart';
import 'package:flutter_money_app/data/data_state_notifier.dart';
import 'package:flutter_money_app/extensions/date_extensions.dart';
import 'package:flutter_money_app/extensions/expenses_extensions.dart';
import 'package:flutter_money_app/extensions/number_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../charts/monthly_chart.dart';
import '../charts/weekly_chart.dart';
import '../charts/yearly_chart.dart';
import '../data/transaction.dart';
import '../data/user_info.dart';
import '../types/period.dart';
import '../utils/constants.dart';
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
];

class Stats extends ConsumerWidget {
  Stats({Key? key}) : super(key: key);

  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void setStateValues(int page) {
      var filterResults = ref
          .read(transactionProvider.notifier)
          .state
          .filterByPeriod(periods[ref.watch(selectedPeriodIndex)], page);

      var expense = filterResults[0] as List<Transaction>;
      var start = filterResults[1] as DateTime;
      var end = filterResults[2] as DateTime;
      var numOfDays = end.difference(start).inDays;

      ref.read(expenses.notifier).state = expense;
      ref.read(expensesFiltered.notifier).state = expense;
      ref.read(startDate.notifier).state = start;
      ref.read(endDate.notifier).state = end;
      ref.read(spentInPeriod.notifier).state = ref.watch(expenses).sumExpense();
      ref.read(avgPerDay.notifier).state = ref.watch(spentInPeriod) / numOfDays;
    }

    final List<Transaction> transactionList = ref.watch(transactionProvider);

    double defaultWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      /* body: Padding(
        padding: const EdgeInsets.all(defaultSpacing),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ */
      appBar: AppBar(
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
        leading: IconButton(
          icon: const Icon(
          Icons.arrow_back_ios,
          color: fontDark,
        ),
         onPressed: (){
          ref.read(currentPageIndex.notifier).state= ref.watch(precedentPageIndex);
        },),
      ),
      /*  */

      body: SafeArea(
        left: true,
        top: true,
        right: true,
        bottom: true,
        child: PageView.builder(
            controller: ref.watch(controllerPage),
            onPageChanged: (newPage) {
              ref.read(currentPage.notifier).state = newPage;
              setStateValues(newPage);
            },
            itemCount: ref.watch(numberOfPages),
            reverse: true,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
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
                                      periods[index].name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: ref.watch(
                                                              selectedPeriodIndex) !=
                                                          null &&
                                                      ref.watch(
                                                              selectedPeriodIndex) ==
                                                          index
                                                  ? Colors.blue[300]
                                                  : fontSubHeading,
                                              fontSize: fontSizeBody),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  ref.read(selectedPeriodIndex.notifier).state =
                                      index;

                                  setStateValues(0);
                                  ref
                                      .read(controllerPage.notifier)
                                      .state
                                      .jumpToPage(0);
                                }),
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
                    height: defaultSpacing / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${ref.watch(startDate).shortDate} - ${ref.watch(endDate).shortDate}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Row(children: [
                              Text(
                                "USD ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: fontSubHeading,
                                        fontWeight: FontWeight.w400),
                              ),
                              Text(
                                ref
                                    .watch(spentInPeriod)
                                    .removeDecimalZeroFormat(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ]),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Avg/day",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                Text(
                                  "USD ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: fontSubHeading,
                                          fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  ref
                                      .watch(avgPerDay)
                                      .removeDecimalZeroFormat(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  (() {
                    switch (ref.watch(selectedPeriodIndex)) {
                      case 0:
                        return WeeklyChart(
                            expenses: ref.watch(expenses).groupWeekly());
                      case 1:
                        return MonthlyChart(
                          expenses: ref.watch(expenses),
                          startDate: ref.watch(startDate),
                          endDate: ref.watch(endDate),
                        );
                      case 2:
                        return YearlyChart(expenses: ref.watch(expenses));
                      default:
                        return const Text("");
                    }
                  }()),
                  (() {
                    if (transactionList.isEmpty) {
                      return const Text("No data for selected period!");
                    } else {
                      return Expanded(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: defaultSpacing,
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
                                      decoration: BoxDecoration(
                                          color: Colors.transparent),
                                      child: ListView.builder(
                                        itemCount: 10,
                                        itemBuilder: (context, index) =>
                                            Container(
                                          width: defaultWidth / 2.8,
                                          height: 80,
                                          color: Colors.transparent,
                                          child: ListTile(
                                              title: Container(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60),
                                                    color: background),
                                                child: Center(
                                                  child: Text(
                                                    _listCategory[index],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: ref.watch(
                                                                            selectedCategoryIndex) !=
                                                                        null &&
                                                                    ref.watch(
                                                                            selectedCategoryIndex) ==
                                                                        index
                                                                ? Colors
                                                                    .blue[300]
                                                                : fontSubHeading,
                                                            fontSize:
                                                                fontSizeBody),
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                ref
                                                    .read(selectedCategoryIndex
                                                        .notifier)
                                                    .state = index;

                                                var filteredCategory = ref
                                                    .read(expenses.notifier)
                                                    .state
                                                    .filterByCategory(ref.watch(
                                                        selectedCategoryIndex));
                                                ref
                                                        .read(expensesFiltered
                                                            .notifier)
                                                        .state =
                                                    filteredCategory[0]
                                                        as List<Transaction>;
                                              }),
                                        ),
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    ),
                                  ],
                                ),
                                ...ref.watch(expensesFiltered).map(
                                    (transaction) => TransactionWidget(
                                        transaction: transaction)),
                                const SizedBox(
                                  height: defaultSpacing,
                                ),
                              ],
                            )),
                      );
                    }
                  }()),
                ]),
              );
            }),
      ),

      /*     const SizedBox(
                height: defaultSpacing * 2,
              ),
               */
      //]
    );
  }
}
