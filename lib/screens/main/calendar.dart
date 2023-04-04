import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  final User user;
  const CalendarScreen({super.key, required this.user});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  late User _currentUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Screen'),
      ),
<<<<<<< Updated upstream
      body: Column(children: const [
        Text('This is calendar page')
      ],
=======
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
                  return _events[date]?.toList() ?? [];
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.green,
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
>>>>>>> Stashed changes
      ),
    );
  }
}
