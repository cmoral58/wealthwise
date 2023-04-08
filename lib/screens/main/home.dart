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

  final GoogleSheetsApi _googleSheetsApi = GoogleSheetsApi();
  final TextEditingController _textController = TextEditingController();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _googleSheetsApi.init();
    _selectedDate = DateTime.now();
    _textController.text = _selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : '';
  }

  // collect user input
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  // enter the new transaction into the spreadsheet
  void _enterTransaction() {
    GoogleSheetsApi.insert(
      _textcontrollerITEM.text,
      _textcontrollerAMOUNT.text,
      _isIncome,
      widget.user.uid,
      _selectedDate,
    );

    GoogleSheetsApi.loadTransactions();
    setState(() {});
  }



  // new transaction
  void _newTransaction() {
    _textcontrollerITEM.text = '';
    _textcontrollerAMOUNT.text = '';
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                title: const Text('N E W  T R A N S A C T I O N'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Expense'),
                          Switch(
                            value: _isIncome,
                            onChanged: (newValue) {
                              setState(() {
                                _isIncome = newValue;
                              });
                            },
                          ),
                          const Text('Income'),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Amount?',
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter an amount';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerAMOUNT,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'For what?',
                              ),
                              controller: _textcontrollerITEM,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Select Date',
                              ),
                              controller: _textController,
                              onTap: () async {
                                DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2021),
                                  lastDate: DateTime(2030),
                                );
                                if (selectedDate != null) {
                                  setState(() {
                                    _selectedDate = selectedDate;
                                    _textController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  MaterialButton(
                    color: Colors.grey[600],
                    child:
                        const Text('Cancel', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        _textController.clear();
                      });
                    },
                  ),
                  MaterialButton(
                    color: Colors.grey[600],
                    child: const Text('Enter', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _enterTransaction();
                        Navigator.of(context).pop();
                        setState(() {
                          _textController.clear();
                        });
                      }
                    },
                  )
                ],
              );
            },
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _textcontrollerAMOUNT.dispose();
    _textcontrollerITEM.dispose();

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
              expense: GoogleSheetsApi.calculateExpense(widget.user.uid).toStringAsFixed(2),
            ),
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: StreamBuilder<List<List<dynamic>>>(
                        stream: Stream.fromIterable([GoogleSheetsApi.currentTransactions]),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<List<String>> data = snapshot.data!.map((list) => list.map((value) => value.toString()).toList()).toList();
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  if(data[index][3] == widget.user.uid) {
                                    return MyTransaction(
                                      transactionName: data[index][0],
                                      money: data[index][1],
                                      expenseOrIncome: data[index][2],
                                      userId: widget.user.uid,
                                      selectedDate: _selectedDate,
                                      index: index,
                                    );
                                  } else {
                                    return Container();
                                  }
                                }
                            );
                          } else {
                            return const LoadingCircle();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            PlusButton(
              function: _newTransaction,
            ),
          ],
        ),
      ),
    );
  }
}