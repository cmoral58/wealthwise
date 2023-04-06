import 'package:flutter/material.dart';
import 'package:wealthwise/screens/main/homeUtils/loading_circle.dart';
import 'package:wealthwise/utils/google_sheets_Api.dart';

class MyTransaction extends StatefulWidget {
  final String transactionName;
  final String money;
  final String expenseOrIncome;
  final int index;

  const MyTransaction({super.key,
    required this.transactionName,
    required this.money,
    required this.expenseOrIncome,
    required this.index,
  });

  @override
  State<MyTransaction> createState() => _MyTransactionState();
}

class _MyTransactionState extends State<MyTransaction> {
  bool _isDeleting = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(15),
          color: Colors.grey[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[500]),
                    child: const Center(
                      child: Icon(
                        Icons.attach_money_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(widget.transactionName,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      )),
                ],
              ),
              Text(
                '${widget.expenseOrIncome == 'expense' ? '-' : '+'}\$${widget.money}',
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color:
                      widget.expenseOrIncome == 'expense' ? Colors.red : Colors.green,
                ),
              ),
              _isDeleting
              ? const LoadingCircle()
                  : IconButton(
                onPressed: () async {
                  setState(() {
                    _isDeleting = true;
                  });

                  try {
                    await GoogleSheetsApi.deleteTransaction(widget.index);
                  } catch (e) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //     content: Text('Failed to delete transaction.'),
                    //     backgroundColor: Colors.red,
                    //   ),
                    // );
                    print(e);
                  }

                  setState(() {
                    _isDeleting = false;
                  });
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
