import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/task_model.dart';
import '../models/user_model.dart';

class AppViewModel extends ChangeNotifier{
  List<Task> tasks =  <Task>[];
  User user = User("Jogn Garza");

  Color clrLvl1 = Colors.grey.shade50;
  Color clrLvl2 = Colors.grey.shade200;
  Color clrLvl3 = Colors.grey.shade800;
  Color clrLvl4 = Colors.grey.shade900;

  void addTask(Task newTask) {
    tasks.add(newTask);
    notifyListeners();
  }

  void bottomSheetBuilder(Widget bottomSheetView, BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      context: context,
      builder: ((context){
        return bottomSheetView;
      }));
  }
}