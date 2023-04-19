import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlanningScreen extends StatefulWidget {
  final User user;
  const PlanningScreen({super.key, required this.user});

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  late User _currentUser;

  @override
  Widget build(BuildContext context) {
    return Text('Planning Screen');
  }
}
