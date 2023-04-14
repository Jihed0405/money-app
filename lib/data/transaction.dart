import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

var now = DateTime.now();
var yesterday = now.subtract(const Duration(days: 1));
var twoDaysAgo = now.subtract(const Duration(days: 2));
var threeDaysAgo = now.subtract(const Duration(days: 3));
var eightDaysAgo = now.subtract(const Duration(days: 8));
var lastYear = now.subtract(const Duration(days: 365));

enum TransactionType { outflow, inflow }

enum ItemCategoryType {
  fashion,
  grocery,
  payments,
  transport,
  entertainment,
  travel,
  homeRent,
  pet,
  extra
}

class Transaction {
  final int id;
  final String categoryType;
  TransactionType transactionType;
  final String itemCategoryName;
  final String itemName;
   double amount;
   DateTime date;
  Transaction(
    this.id,
    this.categoryType,
    this.transactionType,
    this.itemCategoryName,
    this.itemName,
    this.amount,
    this.date,
  );

  get dayInWeek {
    DateFormat format = DateFormat("EEEE");
    return format.format(date);
  }

  get dayInMonth {
    return date.day;
  }

  get month {
    DateFormat format = DateFormat("MMM");
    return format.format(date);
  }

  get year {
    return date.year;
  }

  /* factory Transaction.fromJson(json) {
    return Transaction(
      this.id : json['id'] ,
      categoryType:json['categoryType'],
      transactionType: json['type']  ,
      itemCategoryName:json['itemCategoryName'] ,
      itemName:json['itemName'] ,
      amount:json['amount'] ,
      date:json['date'] ,
    );
  }
   Map<String, dynamic> toJson() => {
    'id' : id,
    'categoryType': categoryType,
    'type': transactionType,
    
  }; */
}

List<Transaction> transaction1 = [
  Transaction(1, "Fashion", TransactionType.outflow, "Shoes", "Sneakers Nike",
      40, DateTime(now.year, now.month, now.day, 13, 37, 24)),
  Transaction(2, "Fashion", TransactionType.outflow, "Bag", "Gucci Flax", 40,
      DateTime(yesterday.year, yesterday.month, yesterday.day, 11, 32, 07)),
  Transaction(
      3,
      "Payments",
      TransactionType.inflow,
      "Payments",
      "Transfer from audrew",
      190,
      DateTime(twoDaysAgo.year, twoDaysAgo.month, twoDaysAgo.day, 18, 52, 48)),
  Transaction(
      4,
      "Grocery",
      TransactionType.outflow,
      "Food",
      "Chicken wing",
      35,
      DateTime(
          threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 12, 00, 00)),
  Transaction(
    5,
    "Transport",
    TransactionType.outflow,
    "Transport",
    "Topup Uber",
    20.00,
    DateTime(
        eightDaysAgo.year, eightDaysAgo.month, eightDaysAgo.day, 21, 13, 22),
  ),
  Transaction(
    6,
    "Fashion",
    TransactionType.outflow,
    "Tshirt",
    "Tshirt 2 pcs",
    15,
    DateTime(lastYear.year, lastYear.month, lastYear.day, 21, 13, 22),
  ),
  Transaction(
    7,
    "Fashion",
    TransactionType.outflow,
    "Pants",
    "Pants 1 pcs  ",
    10.05,
    DateTime(lastYear.year, lastYear.month, lastYear.day, 21, 13, 22),
  ),
];

List<Transaction> transaction2 = [
  Transaction(
      9,
      "Payments",
      TransactionType.inflow,
      "Payments",
      "Transfer from my company",
      2200,
      DateTime(
          threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 12, 00, 00)),
  Transaction(
      10,
      "Payments",
      TransactionType.inflow,
      "Payments",
      "Transfer from my company",
      2200,
      DateTime(lastYear.year, lastYear.month, lastYear.day, 21, 13, 22)),
  Transaction(
    11,
    "Entertainment",
    TransactionType.outflow,
    "Barcelone's game",
    "Camp Nou game vs RealMadrid ",
    35,
    DateTime(lastYear.year, lastYear.month, lastYear.day, 21, 13, 22),
  ),
  Transaction(
    12,
    "Travel",
    TransactionType.outflow,
    "thailand travel",
    "visit Kata Beach",
    580,
    DateTime(lastYear.year, lastYear.month, lastYear.day, 21, 13, 22),
  ),
  Transaction(
    13,
    "Home Rent",
    TransactionType.outflow,
    "Home Rent",
    "monthly rent",
    600,
    DateTime(lastYear.year, lastYear.month, lastYear.day, 21, 13, 22),
  ),
  Transaction(
    14,
    "Pet",
    TransactionType.outflow,
    "Pet food",
    "Pet food",
    10.00,
    DateTime(lastYear.year, lastYear.month, lastYear.day, 21, 13, 22),
  ),
  Transaction(
    15,
    "extra",
    TransactionType.outflow,
    "Café",
    "hanging out café",
    4.00,
    DateTime(lastYear.year, lastYear.month, lastYear.day, 21, 13, 22),
  ),
];
