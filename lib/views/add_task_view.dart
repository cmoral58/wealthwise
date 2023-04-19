import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:wealthwise/view_models/app_view_model.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder:(context, viewmodel, child){
      return SizedBox(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: viewmodel.clrLvl3,
            foregroundColor: viewmodel.clrLvl1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20))),
        onPressed: () {
          viewmodel.bottomSheetBuilder(
            Container(height: 100, color: Colors.amber), context
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
          ))
      );
  });
  }
}
