import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SummaryChart extends StatefulWidget {
  const SummaryChart({Key? key}) : super(key: key);

  @override
  State<SummaryChart> createState() => _SummaryChartState();
}

class _SummaryChartState extends State<SummaryChart> {
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('M O N T H L Y  E X P E N S E S'),
      content: Stack(
        children: <Widget>[
          Text('expenses')
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, 
            child: Text('leave')
        )
      ],
    );
  }

}
