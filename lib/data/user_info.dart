import 'package:flutter_money_app/data/transaction.dart';

class UserInfo{
  final String name;
  final String firstName;
  final String email;
  final String totalBalance;
  final String inflow;
  final String outflow;
  final List<Transaction> transactions;
  const UserInfo(
              {required this.name,
              required this.firstName,
              required this.email,
              required this.totalBalance
              ,required this.inflow,
              required this.outflow,
              required this.transactions});
}
const userData= UserInfo(
  name:"Timberline",
  firstName:"Jacob",
  email:"Jacobtimber@gmail.com",
  totalBalance: "4,586.00",
  inflow: "2,400.00",
  outflow: "710.00",
  transactions: transaction2
);