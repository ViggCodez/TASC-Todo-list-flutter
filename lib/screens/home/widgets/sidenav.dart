import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasc/screens/home/home.dart';
import 'package:tasc/theme/theme.dart';

import '../../others/profile/profilepg.dart';
import 'add_task_bar.dart';
import 'buttons/good.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: preprimClr,
            ),
            child: GreetingWidget(),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Get.to(HomePage());
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Create Task'),
            onTap: () {
              Get.to(AddTaskPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.more),
            title: Text('More'),
            onTap: () {
              Get.to(ProfileScreen());
            },
          ),
        ],
      ),
    );
  }
}
