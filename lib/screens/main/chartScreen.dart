import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataPoint {
  final String name;
  final double value;

  DataPoint(this.name, this.value);
}

class ChartScreen extends StatefulWidget {
  final User user;
  final String userId;


  const ChartScreen({super.key, required this.userId, required this.user});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  late TextEditingController _nameController;
  late TextEditingController _valueController;
  late CollectionReference _dataCollection;
  late User _currentUser;
  late String _userID;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    _userID = _currentUser.uid;
    _nameController = TextEditingController();
    _valueController = TextEditingController();
    _dataCollection =
        FirebaseFirestore.instance.collection('data_${widget.userId}');
  }

  Future<void> _addData() async {
    final name = _nameController.text.trim();
    final value = double.tryParse(_valueController.text.trim()) ?? 0;

    if (name.isNotEmpty) {
      await _dataCollection.add({
        'name': name,
        'value': value,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _nameController.clear();
      _valueController.clear();
    }
  }

  Future<void> _editData(DocumentSnapshot doc) async {
    final newName = _nameController.text.trim();
    final newValue = double.tryParse(_valueController.text.trim()) ?? 0;

    if (newName.isNotEmpty) {
      await _dataCollection.doc(doc.id).update({
        'name': newName,
        'value': newValue,
      });
    }
  }

  Future<void> _deleteData(DocumentSnapshot doc) async {
    await _dataCollection.doc(doc.id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _dataCollection.orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final data = snapshot.data!.docs.map((doc) {
          final name = doc['name'];
          final value = doc['value'] as double;
          return ChartData(name: name, value: value);
        }).toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Chart Screen'),
          ),
          body: Column(
            children: [
              Expanded(
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <ColumnSeries<ChartData, String>>[
                    ColumnSeries<ChartData, String>(
                      dataSource: data,
                      xValueMapper: (ChartData sales, _) => sales.name,
                      yValueMapper: (ChartData sales, _) => sales.value,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelAlignment: ChartDataLabelAlignment.top,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(hintText: 'Name'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _valueController,
                        decoration: const InputDecoration(hintText: 'Value'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _addData,
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.docs[index];
                    final name = doc['name'];
                    final value = doc['value'] as double;

                    return Dismissible(
                      key: Key(doc.id),
                      onDismissed: (_) => _deleteData(doc),
                      child: ListTile(
                        title: Text(name),
                        subtitle: Text(value.toStringAsFixed(2)),
                        trailing: IconButton(
                          onPressed: () {
                            _nameController.text = name;
                            _valueController.text = value.toStringAsFixed(2);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Edit Data'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: _nameController,
                                      decoration: const InputDecoration(
                                          hintText: 'Name'),
                                    ),
                                    const SizedBox(height: 16),
                                    TextField(
                                      controller: _valueController,
                                      decoration: const InputDecoration(
                                          hintText: 'Value'),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      _nameController.clear();
                                      _valueController.clear();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _editData(doc);
                                      _nameController.clear();
                                      _valueController.clear();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChartData {
  final String name;
  final double value;

  ChartData({required this.name, required this.value});
}