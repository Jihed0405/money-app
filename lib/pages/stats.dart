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
   final PageController _controller = PageController(initialPage: 0);
   set _currentPage(int value) {
    setStateValues(value);
  }
    DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
   int get _numberOfPages {
    switch (periods[_selectedPeriodIndex]) {
      case Period.day:
        return 365; // not used
      case Period.week:
        return 53;
      case Period.month:
        return 12;
      case Period.year:
        return 1;
    }
  }
   int _periodIndex = 1;
    double _spentInPeriod = 0;
  double _avgPerDay = 0;
  int get _selectedPeriodIndex => _periodIndex;
  set _selectedPeriodIndex(int value) {
    _periodIndex = value;
    setStateValues(0);
    _controller.jumpToPage(0);
  }
@override
  void initState() {
    super.initState();
    setStateValues(0);
  }
   void setStateValues(int page) {
    var filterResults = transaction2.filterByPeriod(periods[_selectedPeriodIndex], page);

    var expenses = filterResults[0] as List<Transaction>;
    var start = filterResults[1] as DateTime;
    var end = filterResults[2] as DateTime;
    var numOfDays = end.difference(start).inDays;
List<Transaction> _expenses = [];
    setState(() {
      _expenses = transaction2;
      _startDate = start;
      _endDate = end;
      _spentInPeriod = expenses.sum();
      _avgPerDay = _spentInPeriod / numOfDays;
    });
  }
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
void dispose() {
   _controller.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    
    double defaultWidth = MediaQuery.of(context).size.width;
    return Scaffold(
       backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      /* body: Padding(
        padding: const EdgeInsets.all(defaultSpacing),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ */
             appBar:  AppBar(
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
             /*  */
             
               
                   
                body:SafeArea(
                  left: true,
                  top: true,
                  right: true,
                  bottom: true,
                  child: PageView.builder(
                    controller: _controller,
                    onPageChanged: (newPage)=>_currentPage = newPage,
                    itemCount: _numberOfPages,
                    reverse: true,  
                    itemBuilder:(context,index){
                       return Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(children: [

 Row(
                children: [
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(bottom: 10),
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
                height: defaultSpacing /2,
              ),








                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text( "${_startDate.shortDate} - ${_endDate.shortDate}",
                            style: const TextStyle(fontSize: 20),),
                            Container(
                              margin: const  EdgeInsets.only(top: 8) ,
                              child: Row(children: [
                                const Text(
                                  "USD ",
                                  style: TextStyle(
                                    color: fontSubHeading,
                                  ),
                                ),
                                Text(
                                  _spentInPeriod.removeDecimalZeroFormat(),
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
                                  const Text(
                            "Avg/day",
                            style: TextStyle(fontSize: 20),
                          ),  Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                const Text(
                                  "USD ",
                                  style: TextStyle(
                                    color: fontSubHeading,
                                  ),
                                ),
                                Text(
                                  _avgPerDay.removeDecimalZeroFormat(),
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
                    switch (_selectedPeriodIndex) {
                      case 1:
                        return WeeklyChart(expenses: transaction2.groupWeekly());
                      case 2:
                        return MonthlyChart(
                          expenses: transaction2,
                          startDate: _startDate,
                          endDate: _endDate,
                        );
                      case 3:
                        return YearlyChart(expenses: transaction2);
                      default:
                        return const Text("");
                    }
                  }()),
                  (() {
                    if (transaction2.isEmpty) {
                      return const Text("No data for selected period!");
                    } else {
                      return 
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child:Column(children: [
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
                                    
                                    ...userData.transactions.map((transaction) =>
                                        TransactionWidget(transaction: transaction)),
                                    const SizedBox(
                                      height: defaultSpacing,
                                    ),],)),
                      );
                    }
                  }()),
                
                
                          
                        ]),
                       ); 
                    } ),
                ),
              
          /*     const SizedBox(
                height: defaultSpacing * 2,
              ),
               */
            //]
            );
  }
}
