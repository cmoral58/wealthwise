import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wealthwise/screens/main/homeUtils/loading_circle.dart';
import 'package:wealthwise/screens/main/homeUtils/plus_button.dart';
import 'package:wealthwise/screens/main/homeUtils/top_card.dart';
import 'package:wealthwise/screens/main/homeUtils/transaction.dart';
import 'package:wealthwise/utils/google_sheets_Api.dart';

import 'package:gsheets/gsheets.dart';


class HomePage extends StatefulWidget {
   final User user;
   const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
   }

  // wait for the data to be fetched from google sheets
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel();
      } else {
        if(!mounted) return;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // start loading until the data arrives
    if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
      startLoading();
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TopNeuCard(
                    balance: (GoogleSheetsApi.calculateIncome(widget.user.uid) -
                            GoogleSheetsApi.calculateExpense(widget.user.uid))
                        .toStringAsFixed(2),
                    income: GoogleSheetsApi.calculateIncome(widget.user.uid).toStringAsFixed(2),
                    expense: GoogleSheetsApi.calculateExpense(widget.user.uid).toStringAsFixed(2), user: widget.user,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

