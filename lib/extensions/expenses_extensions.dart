
import 'package:flutter_money_app/data/transaction.dart';
import '../types/period.dart';
import 'package:flutter_money_app/extensions/date_extensions.dart';

extension ExpensesExtension on List<Transaction> {
  List filterByPeriod(Period period, int periodIndex) {
    List<Transaction> expenses = [];
    DateTime startDate;
    DateTime endDate;
    DateTime now = DateTime.now();

    switch (period) {
      
      case Period.week:
        int diffSinceMonday = now.weekday - 1;
        startDate =
            now.subtract(Duration(days: diffSinceMonday + 7 * periodIndex));
        endDate = startDate.add(const Duration(days: 6));
        break;
      case Period.month:
        startDate = DateTime(now.year, now.month - periodIndex, 1);
        endDate = DateTime(now.year, now.month - periodIndex + 1, 0);
        break;
      case Period.year:
        startDate = DateTime(now.year - 1, 1, 1);
        endDate = DateTime(now.year, 12, 31);
        break;
    }

    startDate =
        DateTime(startDate.year, startDate.month, startDate.day, 0, 0, 0);
    endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);

    forEach((element) {
      if (element.date.isBetween(startDate, endDate)&&element.transactionType==TransactionType.outflow) {
        expenses.add(element);
      }

    });

    return [expenses, startDate, endDate];
  }
 List filterByCategory(int categoryIndex) {
    List<Transaction> expenses = [];
    
    forEach((element) {
      if(getCategory(categoryIndex)=="All"){
        expenses.add(element);
      }
      if (element.categoryType==getCategory(categoryIndex)) {
        expenses.add(element);
      }
     });
     return [expenses];

 }
 List filterExpenses() {
    List<Transaction> expenses = [];
  
      forEach((element) {
      if (element.transactionType==TransactionType.outflow) {
        expenses.add(element);
      }

    });
     return [expenses];

 }
  List filterIncome() {
    List<Transaction> incomes = [];
  
      forEach((element) {
      if (element.transactionType==TransactionType.inflow) {
        incomes.add(element);
      }

    });
     return [incomes];

 }
  double sum() {
    double sum = 0;
    forEach((element) {
      sum += element.amount;
    });
    return sum;
  }

  double sumIncome() {
    double sum = 0;
    forEach((element) {
      if(element.transactionType==TransactionType.inflow) {
        sum += element.amount;
      }
    });
    return sum;
  }
  
  
  double sumExpense() {
    double sum = 0;
    forEach((element) {
      if(element.transactionType==TransactionType.outflow) {
        sum += element.amount;
      }
    });
    return sum;
  }
 
  groupWeekly() {
    final Map<String, List<Transaction>> grouped = {
      "Monday": [],
      "Tuesday": [],
      "Wednesday": [],
      "Thursday": [],
      "Friday": [],
      "Saturday": [],
      "Sunday": [],
    };

    forEach((element) {
      grouped[element.dayInWeek]!.add(element);
    });

    return grouped;
  }

  groupMonthly(DateTime startDate) {
    final numOfDays = DateTime(startDate.year, startDate.month + 1, 0).day;
    final Map<int, List<Transaction>> grouped =
        List.generate(numOfDays, (index) => <Transaction>[]).asMap();

    forEach((element) {
      grouped[element.dayInMonth - 1]!.add(element);
    });

    return grouped;
  }

  groupYearly() {
    final Map<int, List<Transaction>> grouped =
        List.generate(12, (index) => <Transaction>[]).asMap();

    forEach((element) {
      grouped[element.date.month - 1]!.add(element);
    });

    return grouped;
  }
  String getCategory(int categoryIndex ){
    switch(categoryIndex){
      case 0 :
      return "All";
      case 1 : 
       return "Fashion";
       case 2 :
       return 'Grocery';
       case 3 : 
      return'Transport'       ;
       case 4:
      return'Entertainment' ;
       case 5:
        return'Travel'     ;
       case 6:
  return'Home Rent'     ;
       case 7:
  return'Pet'     ;
       case 8:
   return"Investments"      ;
       case 9:
     return 'Extra'  ;
        default :return "";
    }
  }

 
}

  