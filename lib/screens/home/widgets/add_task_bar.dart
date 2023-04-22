import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasc/controllers/task_controller.dart';
import 'package:tasc/models/task.dart';
import 'package:tasc/screens/home/widgets/buttons/button.dart';
import 'package:tasc/screens/home/widgets/input_field.dart';
import 'package:tasc/theme/theme.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "11:59 PM";
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];

  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create a task",
                style: subHeadingStyle,
              ),
              MyInputField(
                  title: "Title",
                  hint: "Enter your title",
                  controller: _titleController),
              MyInputField(
                  title: "Note",
                  hint: "Enter your note",
                  controller: _noteController),
              MyInputField(
                title: "Date",
                hint: DateFormat('dd/MM/yyyy').format(_selectedDate),
                widget: IconButton(
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    print("Hii there");
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: MyInputField(
                    title: "Start Time",
                    hint: _startTime,
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(
                            isStartTime:
                                true); //using bool we can diff whether user clicked on start/end time
                      },
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: MyInputField(
                    title: "End Time",
                    hint: _endTime,
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isStartTime: false);
                      },
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ))
                ],
              ),
              MyInputField(
                title: "Reminder",
                hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 30,
                  elevation: 4,
                  style: subTitleStyle,
                  underline:
                      Container(height: 0), //error of line showing solved
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              MyInputField(
                title: "Repeat",
                hint: "$_selectedRepeat",
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 30,
                  elevation: 4,
                  style: subTitleStyle,
                  underline:
                      Container(height: 0), //error of line showing solved
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  items:
                      repeatList.map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value!, style: TextStyle(color: Colors.grey)),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPriority(),
                  MyButton(label: "Create Task", onTap: (() => _validateData()))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(
          "Add Task",
          style: headingStyle,
        ),
      ),
      elevation: 1, //appbar shadow
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios_new_sharp,
            size: 20, color: Get.isDarkMode ? Colors.white : Colors.black),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/effperson.jpg"),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      //addtodb
      _addTaskToDB();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required !",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: redClr,
          icon: Icon(
            Icons.warning_amber_rounded,
            color: redClr,
          ));
    }
  }

  //must be same as model
  _addTaskToDB() async {
    int value = await _taskController.addTask(
        task: Task(
      note: _noteController.text,
      title: _titleController.text,
      date: DateFormat('dd/MM/yyyy').format(_selectedDate),
      startTime: _startTime,
      endTime: _endTime,
      remind: _selectedRemind,
      repeat: _selectedRepeat,
      color: _selectedColor,
      isCompleted: 0,
    ));
    print("My id is " + "$value");
  }

  _colorPriority() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        SizedBox(
          height: 8.0,
        ),
        Wrap(
            children: List<Widget>.generate(3, (int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedColor = index;
                print("$index");
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 14,
                backgroundColor: index == 0
                    ? greenClr
                    : index == 1
                        ? yellowClr
                        : redClr,
                child: _selectedColor == index
                    ? Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 16,
                      )
                    : Container(),
              ),
            ),
          );
        })),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2123)); //must be bigger than initial date

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    } else {
      print("It's null or something is wrong");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime
        .format(context); //context is used to change it to sting format
    if (pickedTime == null) {
      print("Time cancelled");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          //_startTime --> "10:10 AM" so we convert to int by spliting between patterns
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ));
  }
}
