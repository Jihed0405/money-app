import 'dart:convert';
import'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_money_app/pages/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../data/data_state_notifier.dart';
import '../data/transaction.dart';
import '../utils/constants.dart';
import '../widget/profile_account_info_tile.dart';
import '../widget/transaction_widget.dart';

List<Transaction> myList = [];

class Wallet extends ConsumerWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Transaction> transactionList = ref.watch(transactionProvider);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
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
                height: defaultSpacing*2,
              ),
               Padding(
                 padding: const EdgeInsets.all(18.0),
                 child: Container(
                  color: background,
                   child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(defaultRadius)),
                        child: Image.asset(
                      fit:  Platform.isAndroid||Platform.isIOS?BoxFit.contain:null,
                        width:Platform.isWindows?400:800,
                          "assets/images/wallet.jpg",
                      
                        ),
                      ),
                 ),
               ),
          
          
           Padding(
            padding: const EdgeInsets.all(defaultSpacing*2),
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Goals",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: fontHeading),
                ),
                const SizedBox(
                  height: defaultSpacing / 4,
                ),
                const ProfileAccountInfoTile(
                    imageUrl: 'assets/icons/building.png',
                    title: 'Buy an apartment ',
                    subTitle: 'in 8 years·from personal saving'),
                const ProfileAccountInfoTile(
                    imageUrl: 'assets/icons/sunbed.png',
                    title: 'Trip to Maldives',
                    subTitle: 'in 2 months·from personal saving'),
                    
                const ProfileAccountInfoTile(
                    imageUrl: 'assets/icons/house.png',
                    title: 'My man cave',
                    subTitle: 'in 5 months·from personal saving'),
                     const ProfileAccountInfoTile(
                    imageUrl: 'assets/icons/car-repair.png',
                    title: 'Car repair',
                    subTitle: 'in 10 months·from personal saving'),
           ]),),

            ],),


    )),
    );
        
  }
}
