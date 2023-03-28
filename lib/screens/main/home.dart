import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DateTime today = DateTime.now();
  static const TextStyle lightStyle = TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(111, 146, 240, 1), fontSize: 25.0, fontFamily: 'Montserrat');
  static const TextStyle darkStyle = TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(64, 91, 159, 1), fontSize: 25.0, fontFamily: 'Montserrat');
  static const TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 15.0, fontFamily: 'Montserrat');
  static const TextStyle descriptionStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0, fontFamily: 'Montserrat');

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  late User _currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16.0, top: 20.0),
                child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(text: 'Welcome, ', style: lightStyle),
                        TextSpan(text: '${_currentUser.displayName?.split(' ')[0]}! ', style: darkStyle),
                      ],
                    ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Row(
                      children: const [
                        /// title, description, icon, titleAlignment, descriptionAlignment, iconAlignment, titleStyle, descriptionStyle
                        CardItem('Cash', '\$ 1934.65', Icons.attach_money, Alignment.bottomLeft, Alignment.bottomLeft, Alignment.bottomLeft, titleStyle, descriptionStyle),
                        CardItem('', 'Add User', Icons.add_circle_outline_outlined, Alignment.center, Alignment.bottomCenter, Alignment.bottomLeft, titleStyle, descriptionStyle),
                      ],
                    ),
                    CalendarCard('${today.day}, ${today.year}', 'No events for today', Icons.calendar_month, Alignment.topLeft, Alignment.centerLeft, Alignment.centerLeft, titleStyle, descriptionStyle)
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }
}

/// Custom card items

class CardItem extends StatelessWidget {
  final String title;
  final String description;
  final IconData iconData;
  final Alignment titleAlignment;
  final Alignment descriptionAlignment;
  final Alignment iconAlignment;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;
  const CardItem(this.title, this.description, this.iconData, this.titleAlignment, this.descriptionAlignment, this.iconAlignment, this.titleStyle ,this.descriptionStyle, {super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height / 5.5,
      width: MediaQuery.of(context).size.width / 2 - 40, // - 40 due to margin and padding
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.5,
            offset: Offset(2.0, 2.0),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Align(
              // alignment: Alignment.bottomLeft,
              alignment: titleAlignment,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  title.toUpperCase(),
                  style: titleStyle,
                ),
              ),
            ),
            Align(
              alignment: descriptionAlignment,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: description,
                      style: descriptionStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData iconData;
  final Alignment titleAlignment;
  final Alignment descriptionAlignment;
  final Alignment iconAlignment;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;
  const CalendarCard(this.title, this.description, this.iconData, this.titleAlignment, this.descriptionAlignment, this.iconAlignment, this.titleStyle ,this.descriptionStyle, {super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height / 8,
      width: MediaQuery.of(context).size.width, // - 40 due to margin and padding
      margin: const EdgeInsets.only(left: 20.0, bottom: 10.0, right: 20.0),
      padding: const EdgeInsets.only(left: 20.0, bottom: 10.0, right: 20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.5,
            offset: Offset(2.0, 2.0),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Align(
              // alignment: Alignment.bottomLeft,
              alignment: titleAlignment,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  title.toUpperCase(),
                  style: titleStyle,
                ),
              ),
            ),
            Align(
              alignment: descriptionAlignment,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: description,
                      style: descriptionStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


