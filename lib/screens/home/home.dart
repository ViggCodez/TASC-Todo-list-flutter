import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tasc/controllers/task_controller.dart';
import 'package:tasc/models/task.dart';
import 'package:tasc/screens/others/profile/profilepg.dart';
import 'package:tasc/screens/home/widgets/add_task_bar.dart';
import 'package:tasc/screens/home/widgets/buttons/button.dart';
import 'package:tasc/screens/home/widgets/buttons/logout.dart';
import 'package:tasc/services/notification_services.dart';
import 'package:tasc/services/theme_services.dart';
import 'package:tasc/theme/theme.dart';
import 'widgets/buttons/good.dart';
import 'widgets/go_premium.dart';
import 'widgets/profile.dart';
import 'widgets/sidenav.dart';
import 'widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var notifyHelper;
  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    print("build method called");
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: context.theme.backgroundColor,
        // backgroundColor: Colors.white,
        // //appBar: _buildAppBar(), //extracted method as _ to make private
        // body: SafeArea(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       ProfileWidget(
        //         name: 'Vignesh Baiju',
        //         email: 'vigneshbaiju.vb@gmail.com',
        //         imageUrl: "https://rb.gy/gtmkqi",
        //         completedTasks: 12,
        //         pendingTasks: 20,
        //         totalTasks: 3,
        //         profileLink: '',
        //       ),
        //       GoPremium(),
        //       LogoutButton(),
        //     ],
        //   ),
        // ),
        appBar: _appBar(
          automaticallyImplyLeading: false,
        ),
        drawer: SideNavigation(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: preprimClr,
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          child: Icon(Icons.menu),
        ),
        body: Column(
          children: [
            _addTaskBar(),
            _addDateBar(),
            SizedBox(height: 10),
            _showTasks(),
          ],
        ),
      ),
    );
  }

  _showTasks() {
    return Expanded(child: Obx(
      () {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              print(_taskController.taskList.length);
              Task task = _taskController
                  .taskList[index]; //Task = model task=instance/obj
              print(task.toJson()); //see in debug console
              if (task.repeat == 'Daily') {
                DateTime date =
                    DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                notifyHelper.scheduledNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    task);

                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                          child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                _showBottomSheet(context, task);
                              },
                              child: TaskTile(task))
                        ],
                      )),
                    ));
              }
              if (task.date == DateFormat('dd/MM/yyyy').format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                          child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                _showBottomSheet(context, task);
                              },
                              child: TaskTile(task))
                        ],
                      )),
                    ));
              } else {
                return Container();
              }
              //task tile ui
            });
      },
    ));
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Get.isDarkMode ? darkGreyClr : Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
          ),
          Spacer(),
          task.isCompleted == 1
              ? Container()
              : _bottomSheetButton(
                  label: "Task Completed",
                  onTap: () {
                    _taskController.markTaskCompleted(task.id!);

                    Get.back();
                  },
                  clr: preprimClr,
                  context: context,
                ),
          _bottomSheetButton(
            label: "Delete Task",
            onTap: () {
              _taskController.delete(task);

              Get.back();
            },
            clr: Colors.red[300]!, //new sdk null safety
            context: context,
          ),
          SizedBox(
            height: 20,
          ),
          _bottomSheetButton(
            label: "Close",
            onTap: () {
              Get.back();
            },
            clr: Colors.red[300]!,
            isClose: true,
            context: context,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }

  _bottomSheetButton(
      {required String label,
      required Function()? onTap,
      required Color clr,
      bool isClose = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              //cond inside cond
              color: isClose == true
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : clr),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
            child: Text(
          label,
          style:
              isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
        )),
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 15),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 70,
        initialSelectedDate: DateTime.now(),
        selectionColor: preprimClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            //margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  style: headingStyle,
                )
              ],
            ),
          ),
          MyButton(
              label: "+ Add Task",
              onTap: () async {
                await Get.to(() => AddTaskPage());
                _taskController.getTasks();
              })
        ],
      ),
    );
  }

  _appBar({required bool automaticallyImplyLeading}) {
    return AppBar(
      elevation: 0, //appbar shadow
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Activated Light Theme"
                  : "Activated Dark Theme");

          //notifyHelper.scheduledNotification();
        },
        child: Icon(
            Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
            size: 20,
            color: Get.isDarkMode ? Colors.white : Colors.black),
      ),
      actions: [
        GestureDetector(
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/effperson.jpg"),
          ),
          onTap: () {
            Get.to(ProfileScreen());
          },
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
//old app bar
  // AppBar _buildAppBar() {
  //   return AppBar(
  //     automaticallyImplyLeading: false, //removing back button
  //     backgroundColor: Colors.white,
  //     elevation: 0, //downt want shadow
  //     title: Row(
  //       children: [
  //         Container(
  //           height: 45,
  //           width: 45,
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(10),
  //             child: Image.asset('assets/images/logo.png'),
  //           ),
  //         ),
  //         SizedBox(width: 10),
  //         Text(
  //           'Hi, Vignesh!',
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 24,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ],
  //     ),
  //     actions: [
  //       Icon(
  //         Icons.more_vert,
  //         color: Colors.black,
  //         size: 35,
  //       )
  //     ],
  //   );
  // }
}
