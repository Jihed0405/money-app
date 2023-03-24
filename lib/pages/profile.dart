import 'package:flutter/material.dart';
import 'package:flutter_money_app/utils/constants.dart';

import '../data/user_info.dart';
import '../widget/profile_account_info_tile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: background,
      
      appBar: AppBar(
        elevation: 0,
        backgroundColor: background,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: fontDark,
        ),
        actions: const [
          Image(image: AssetImage("assets/icons/settings.png"))
        ],
      ),
      body:SingleChildScrollView(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Center(
                child: Column(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(defaultRadius)),
                  child: Image.asset(
                    "assets/images/avatar.jpg",
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: defaultSpacing / 2,
                ),
                ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.zero),
                    child: Column(children: [
                      Text(
                        "${userData.firstName} ${userData.name}",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: fontHeading),
                      ),
                      const SizedBox(
                        height: defaultSpacing / 2,
                      ),
                      Text(
                        userData.email,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: fontSubHeading),
                      ),
                      const SizedBox(
                        height: 2 * defaultSpacing / 3,
                      ),
                      const Chip(
                        backgroundColor: primaryLight,
                        label: Text(
                          "Edit Profile",
                        ),
                        labelStyle: TextStyle(color: primaryGreen),
                      ),
                    ])),
              ],
            )),
          
          
          Padding(
            padding: const EdgeInsets.all(defaultSpacing*2),
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "General",
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
                    imageUrl: 'assets/icons/location-1.png',
                    title: 'Bank Location',
                    subTitle: '7307 Grand, Ava, Flushing NY1347'),
                const ProfileAccountInfoTile(
                    imageUrl: 'assets/icons/wallet.png',
                    title: 'My Wallet',
                    subTitle: 'Manage your saved wallet'),
                const SizedBox(
                  height: defaultSpacing,
                ),
                Text(
                  "Account",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: fontHeading),
                ),
                const SizedBox(
                  height: defaultSpacing,
                ),
                const ProfileAccountInfoTile(
                    imageUrl: 'assets/icons/user-1.png',
                    title: 'My Account',
                    subTitle: ''),
                const SizedBox(
                  height: defaultSpacing,
                ),
                const ProfileAccountInfoTile(
                    imageUrl: 'assets/icons/bell.png',
                    title: 'Notification',
                    subTitle: ''),
                const SizedBox(
                  height: defaultSpacing,
                ),
                const ProfileAccountInfoTile(
                    imageUrl: 'assets/icons/lock-on.png',
                    title: 'Privacy',
                    subTitle: ''),
                const SizedBox(
                  height: defaultSpacing,
                ),
                const ProfileAccountInfoTile(
                    imageUrl: 'assets/icons/info-circle.png',
                    title: 'About',
                    subTitle: ''),
              ],
            ),
          )
        ],
      ),
    ),);
  }
}
