import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wealthwise/screens/main/home.dart';
import 'package:wealthwise/screens/main/homeUtils/view_transactions.dart';

class TopNeuCard extends StatelessWidget {
  final String balance;
  final String income;
  final String expense;
  final User user;

  const TopNeuCard({super.key,
    required this.balance,
    required this.expense, 
    required this.income,
    required this.user,
    });

  @override
   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return ViewTransaction(user: user);
              // return const SummaryChart();
            }
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 4.3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[300],
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(4.0, 4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0),
                const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0),
              ]),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('B A L A N C E',
                    style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                Text(
                  '\$$balance',
                  style: TextStyle(color: Colors.grey[800], fontSize: 40),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_upward,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Income',
                                  style: TextStyle(color: Colors.grey[500])),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('\$$income',
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_downward,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Expense',
                                  style: TextStyle(color: Colors.grey[500])),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('\$$expense',
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}