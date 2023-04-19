import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:wealthwise/view_models/app_view_model.dart';
import 'package:wealthwise/views/bottom_sheets/delete_bottom_sheet_view.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, value, child) {
      return Row(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(left: 15),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text("Welcome Back",
                              style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w400,
                                  color: AppViewModel.clrLvl4)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            AppViewModel.username,
                            style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: AppViewModel.clrLvl4),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  viewModel.bottomSheetBuilder(DeleteBottomSheetView(), context);
                },
              )
              child: Icon(
                Icons.delete,
                size: 40,
              )),
        ],
      );
    });
  }
}
