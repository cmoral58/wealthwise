import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wealthwise/view_models/app_view_model.dart';

import '../../models/task_model.dart';

class AddTaskBottomSheetView extends StatelessWidget {
  const AddTaskBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {

    final TextEditingController entrycontroller = TextEditingController();

    return Consumer<AppViewModel>(builder:(context, viewModel, child){
      return Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
            height: 80,
            child: Center(
                child: SizedBox(
                    height: 40,
                    width: 250,
                    child: TextField(
                        onSubmitted: (value){
                          if(entrycontroller.text.isNotEmpty) {
                            Task newTask = Task(entrycontroller.text, false);
                            viewModel.addTask(newTask);
                            entrycontroller.clear();
                          }
                          Navigator.of(context).pop();
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 5),
                            filled: true,
                            fillColor: viewModel.clrLvl2,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none))),
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: viewModel.clrLvl4,
                        autofocus: true,
                        autocorrect: false,
                        controller: entrycontroller,
                        style: TextStyle(color: viewModel.clrLvl4, fontWeight: FontWeight.w500))
                )
            )),
      );
    });
  }
}