import 'package:get/get.dart';
import 'package:tasc/db/db_helper.dart';
import 'package:tasc/models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  //taskList contains all values from query v
  var taskList = <Task>[].obs;

//is called from _addtaskToDb() from add_task_bar
  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  //gets all the info from table
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    DBHelper.delete(task);
    getTasks();
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
