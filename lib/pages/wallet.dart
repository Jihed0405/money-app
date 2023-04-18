import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_money_app/pages/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../data/data_state_notifier.dart';
import '../data/transaction.dart';
import '../utils/constants.dart';
import '../widget/transaction_widget.dart';

List<Transaction> myList = [];

class Wallet extends ConsumerWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Transaction> transactionList = ref.watch(transactionProvider);

    return SafeArea(
      top: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              centerTitle: true,
              title: Text(
                " My Wallet",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              elevation: 0,
              backgroundColor: background,
              leading: IconButton(
              icon:const Icon(
                Icons.arrow_back_ios,
                color: fontDark,
              ),    onPressed: () {
                      ref.read(currentPageIndex.notifier).state =
                          ref.watch(precedentPageIndex);
                         ref.read(visibleButtonProvider.notifier).state=true;    
                    })
            ),
            const SizedBox(
              height: defaultSpacing,
            ),
             Padding(
               padding: const EdgeInsets.all(16.0),
               child: ClipRRect(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(defaultRadius)),
                    child: Image.asset(
                      fit: BoxFit.contain,
                      "assets/images/Wallet.png",
                      width: 800,
                    ),
                  ),
             ),
        ],
        ),
));
        
  }
}
