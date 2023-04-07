import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EditEventScreen extends StatefulWidget {
  final String userId;
  final User user;
  final String eventId;

  const EditEventScreen({
    Key? key,
    required this.userId,
    required this.user,
    required this.eventId,
  }) : super(key: key);

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _eventDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _eventDate = DateTime.now();
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      final eventRef = FirebaseFirestore.instance
          .collection('events')
          .doc(widget.userId)
          .collection('userEvents')
          .doc(widget.eventId);

      final updatedData = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'eventDate': Timestamp.fromDate(_eventDate),
      };

      try {
        await eventRef.update(updatedData);
        Navigator.of(context).pop();
      } catch (e) {
        if (kDebugMode) {
          print('Error updating event: $e');
        }
        if (kDebugMode) {
          print('updatedData: $updatedData');
        }
        if (kDebugMode) {
          print('eventRef path: ${eventRef.path}');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Icon(Icons.date_range),
                  const SizedBox(width: 8.0),
                  Text(
                    'Date: ${_eventDate.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      final newDate = await showDatePicker(
                        context: context,
                        initialDate: _eventDate,
                        firstDate: DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (newDate != null) {
                        setState(() {
                          _eventDate = newDate;
                        });
                      }
                    },

                    child: const Text('Change'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _saveChanges(),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}