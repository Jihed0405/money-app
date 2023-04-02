import 'package:flutter/material.dart';
import 'package:flutter_money_app/extensions/date_extensions.dart';
import 'package:flutter_money_app/utils/constants.dart';

import '../data/transaction.dart';

class TransactionWidget extends StatelessWidget {
  final Transaction transaction;
    const TransactionWidget({required this.transaction, Key? key}) : super(key: key);
 String getSign(TransactionType type){
      switch(type) {
        case TransactionType.inflow:
        return "+";
        case TransactionType.outflow:
        return "-";
      }
         
    }
  @override
  Widget build(BuildContext context) {
  if(transaction==null){
    return const Text("no data found");
  }
  else {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: defaultSpacing / 2),
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset.zero,
                  blurRadius: 10,
                  spreadRadius: 4)
            ],
            color: background,
            borderRadius: BorderRadius.all(Radius.circular(defaultRadius))),
        child: ListTile(
          leading: Container(
              padding: const EdgeInsets.all(defaultSpacing / 2),
              decoration: BoxDecoration(
                  color: transaction.itemCategoryName == "Shoes"
                      ? const Color(0xFFffd89d)
                      : transaction.transactionType == TransactionType.inflow
                          ? const Color(0xFFeae9e9)
                          : transaction.categoryType ==
                                 "Transport"
                              ? const Color(0xFFbdfff7)
                              : transaction.itemCategoryName == "Pants"
                                  ? const Color(0xFFfff7ac)
                                  : transaction.itemCategoryName == "Tshirt"
                                      ? const Color(0xFFffdcdc)
                                      : transaction.itemCategoryName == "Bag"
                                          ? const Color(0xFFfc9191)
                                       : transaction.categoryType == "Fashion"
                                  ? const Color(0xFFffdcdc)
                                  
                                          : transaction.itemCategoryName ==
                                                  "Food"
                                              ? const Color(0xFFfee45a)
                                                : transaction.categoryType ==
                                                  "Grocery"
                                              ? const Color(0xFFfee45a)
                                              : transaction.categoryType ==
                                                  
                                                          "Entertainment"
                                                  ? const Color(0xFFe63d3d)
                                                  : transaction.categoryType ==
                                                          "Travel"
                                                      ? const Color(0xFF14c9ac)
                                                      : transaction.categoryType ==
                                                              "Home Rent"
                                                          ? const Color(0xFFffc95a)
                                                          : transaction
                                                                      .categoryType ==
                                                                  "Pet"
                                                              ? const Color(
                                                                  0xFF2389e9)
                                                              : const Color(
                                                                  0xFF9d55e3),
                  borderRadius: BorderRadius.circular(defaultRadius / 2)),
              child: transaction.itemCategoryName == "Shoes"
                  ? const Image(image: AssetImage("assets/icons/sneakers.png"))
                  : transaction.itemCategoryName == "Bag"
                      ? const Image(image: AssetImage("assets/icons/bag.png"))
                      : transaction.transactionType == TransactionType.inflow
                          ? const Image(image: AssetImage("assets/icons/money.png"))
                          : transaction.categoryType ==
                                  "Transport"
                              ? const Image(image: AssetImage("assets/icons/car.png"))
                              : transaction.itemCategoryName == "Tshirt"
                                  ? const Image(
                                      image: AssetImage(
                                          "assets/icons/t-shirt.png"))
                                  : transaction.itemCategoryName == "Pants"
                                      ? const Image(
                                          image: AssetImage(
                                              "assets/icons/trousers.png"))
                                                : transaction.categoryType == "Fashion"
                                      ? const Image(
                                          image: AssetImage(
                                              "assets/icons/dress.png"))
                                      : transaction.itemCategoryName == "Food"
                                          ? const Image(
                                              image: AssetImage(
                                                  "assets/icons/hamburger.png"))
                                                  
                                      : transaction.categoryType == "Grocery"
                                          ? const Image(
                                              image: AssetImage(
                                                  "assets/icons/shopping-bag.png"))
                                          : transaction.categoryType ==
                                                  "Entertainment"
                                              ? const Image(
                                                  image: AssetImage(
                                                      "assets/icons/joystick.png"))
                                              : transaction.categoryType ==
                                                      "Travel"
                                                  ? const Image(
                                                      image: AssetImage(
                                                          "assets/icons/plane.png"))
                                                  : transaction.categoryType ==
                                                          
                                                              "Home Rent"
                                                      ? const Image(
                                                          image: AssetImage(
                                                              "assets/icons/home.png"))
                                                      : transaction
                                                                  .categoryType ==
                                                             
                                                                  "Pet"
                                                          ? const Image(
                                                              image: AssetImage(
                                                                  "assets/icons/pawprint.png"))
                                                          : const Image(
                                                              image: AssetImage(
                                                                  "assets/icons/more.png"))),
          title: Text(transaction.itemCategoryName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: fontHeading,
                  fontSize: fontSizeTitle,
                  fontWeight: FontWeight.w700)),
          subtitle: Text(transaction.itemName,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: fontSubHeading, fontSize: fontSizeBody)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("${getSign(transaction.transactionType)}\$ ${transaction.amount}",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color:
                          transaction.transactionType == TransactionType.outflow
                              ? red
                              : primaryDark,
                      fontSize: fontSizeBody)),
              Text(transaction.date.shortDate,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: fontSubHeading, fontSize: fontSizeBody)),
            ],
          ),
        ));
  }
  }
}
