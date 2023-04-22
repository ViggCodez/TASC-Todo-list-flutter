// ignore_for_file: import_of_legacy_library_into_null_safe, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tasc/auth/firebase_auth.dart';
import 'package:tasc/screens/others/profile/click/help.dart';
import 'package:tasc/screens/others/profile/click/premium.dart';
import 'package:tasc/screens/others/profile/click/privacy.dart';
import 'package:tasc/screens/others/profile/click/share.dart';
import 'package:tasc/screens/others/profile/click/tutorial.dart';
import 'package:tasc/screens/others/profile/profile_list_item.dart';
import 'package:tasc/theme/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../home/widgets/buttons/logout.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

getUserInfo() {
  User? user = _auth.currentUser;

  if (user != null) {
    String email = user.email!;
    String? displayName = user.displayName;
    // use the email and display name as needed

  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: kSpacingUnit.w * 5,
                  backgroundImage:
                      const AssetImage('assets/images/effperson.jpg'),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            AuthHelper.user?.email ?? "Welcome User",
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          SizedBox(height: kSpacingUnit.w * 2),
          GestureDetector(
            onTap: () {
              Get.to(PremiumPage());
            },
            child: Container(
              height: kSpacingUnit.w * 4,
              width: kSpacingUnit.w * 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Center(
                child: Text(
                  'Upgrade to PRO',
                  style: kButtonTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 3),
        profileInfo,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );

    return Builder(
      builder: (context) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              SizedBox(height: kSpacingUnit.w * 5),
              header,
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ProfileListItem(
                      icon: Icons.shield_outlined,
                      text: 'Privacy',
                      onTap: () {
                        Get.to(Privacy());
                      },
                    ),
                    ProfileListItem(
                      icon: Icons.help_outline_sharp,
                      text: 'Help & Support',
                      onTap: () {
                        Get.to(HelpAndContactPage());
                      },
                    ),
                    ProfileListItem(
                      icon: Icons.lightbulb_outlined,
                      text: 'Tutorial',
                      onTap: () {
                        Get.to(Tutorial());
                      },
                    ),
                    ProfileListItem(
                      icon: Icons.share,
                      text: 'Share',
                      onTap: () {
                        Get.to(ShareApp());
                      },
                    ),
                    LogoutButton(),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
