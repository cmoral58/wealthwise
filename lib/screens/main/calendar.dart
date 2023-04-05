import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'editEvent.dart';

class CalendarScreen extends StatefulWidget {
  final String userId;
  final User user;

  const CalendarScreen({Key? key, required this.userId, required this.user}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late final DateTime _firstDay = DateTime(DateTime.now().year - 1, 1, 1);
  late final DateTime _lastDay = DateTime(DateTime.now().year + 1, 12, 31);

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  Map<DateTime, List<dynamic>> _events = {};

  Future<Map<DateTime, List<dynamic>>> getEvents() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('events')
        .doc(widget.userId)
        .collection('userEvents')
        .get();

    Map<DateTime, List<dynamic>> events = {};

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      DateTime date = DateTime.parse(data['date'].toDate().toString());
      if (events[date] == null) {
        events[date] = [];
      }
      events[date]!.add(data);
    });

    return events;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  Widget _buildEventList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('events')
          .doc(widget.userId)
          .collection('userEvents')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            Map<String, dynamic> data =
            snapshot.data!.docs[index].data() as Map<String, dynamic>;
            DateTime date = DateTime.parse(data['date'].toDate().toString());

            if (date.year == _selectedDay.year &&
                date.month == _selectedDay.month &&
                date.day == _selectedDay.day) {
              return Card(
                child: ListTile(
                  title: Text(data['title']),
                  subtitle: Text(data['description']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditEventScreen(
                                userId: widget.userId,
                                eventId: snapshot.data!.docs[index].id,
                                user: widget.user,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('events')
                              .doc(widget.userId)
                              .collection('userEvents')
                              .doc(snapshot.data!.docs[index].id)
                              .delete();
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: FutureBuilder<Map<DateTime, List<dynamic>>>(
        future: getEvents(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<DateTime, List<dynamic>>> snapshot) {
          if (snapshot.hasData) {
            _events = snapshot.data!;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar(
                firstDay: _firstDay,
                lastDay: _lastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(_selectedDay, date);
                },
                onDaySelected: _onDaySelected,
                eventLoader: (DateTime date) {
                  // return _events[date] as List;
                  return _events[date]?.toList() ?? [];
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Color.fromARGB(255, 128, 128, 128),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
                    shape: BoxShape.circle,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (BuildContext context, DateTime date,
                      List<dynamic> events) {
                    if (events.isNotEmpty) {
                      return Stack(
                        children: [
                          Positioned(
                            right: 1,
                            bottom: 1,
                            child: _buildMarker(date, events.length),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
              Expanded(child: _buildEventList()),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              DateTime _eventDate = DateTime.now();
              String _eventTitle = '';
              String _eventDescription = '';
              return AlertDialog(
                title: const Text('Add Event'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Date',
                        ),
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2030),
                          );
                          if (selectedDate != null) {
                            _eventDate = selectedDate;
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Title',
                        ),
                        onChanged: (value) {
                          _eventTitle = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Description',
                        ),
                        onChanged: (value) {
                          _eventDescription = value;
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text('Save'),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('events')
                          .doc(widget.userId)
                          .collection('userEvents')
                          .add({
                        'date': _eventDate,
                        'title': _eventTitle,
                        'description': _eventDescription,
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildMarker(DateTime date, int count) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[400],
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: 20.0,
      height: 20.0,
      child: Center(
        child: Text(
          '$count',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}