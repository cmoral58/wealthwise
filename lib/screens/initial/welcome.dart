import 'package:flutter/material.dart';
import 'package:wealthwise/screens/initial/login.dart';
import 'package:wealthwise/screens/initial/register.dart';
import 'package:carousel_slider/carousel_slider.dart';
// current images used are from freepik.com (image by redgreystock on freepik)

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 10,
            ),
            // CarouselSlider(
            //     items: [
            //       Container(
            //         margin: const EdgeInsets.all(8.0),
            //         decoration: BoxDecoration(
            //             gradient: LinearGradient(
            //               begin: Alignment.topRight,
            //               end: Alignment.bottomLeft,
            //               stops: const [
            //                 0.1,
            //                 0.7,
            //               ],
            //               colors: [
            //                 Colors.lightBlue.shade100,
            //                 const Color.fromRGBO(242, 249, 255, 1),
            //               ],
            //             ),
            //           borderRadius: BorderRadius.circular(10.0),
            //           image: const DecorationImage(
            //             image: AssetImage('images/save.png'),
            //             fit: BoxFit.fitWidth,
            //           )
            //         ),
            //       ),
            //       Container(
            //         margin: const EdgeInsets.all(8.0),
            //         decoration: BoxDecoration(
            //             gradient: LinearGradient(
            //               begin: Alignment.topRight,
            //               end: Alignment.bottomLeft,
            //               stops: const [
            //                 0.1,
            //                 0.7,
            //               ],
            //               colors: [
            //                 Colors.lightBlue.shade100,
            //                 const Color.fromRGBO(242, 249, 255, 1),
            //               ],
            //             ),
            //             borderRadius: BorderRadius.circular(10.0),
            //             image: const DecorationImage(
            //               image: AssetImage('images/invest.png'),
            //               fit: BoxFit.fitWidth,
            //             )
            //         ),
            //       ),
            //       Container(
            //         margin: const EdgeInsets.all(8.0),
            //         decoration: BoxDecoration(
            //           gradient: LinearGradient(
            //               begin: Alignment.topRight,
            //               end: Alignment.bottomLeft,
            //               stops: const [
            //                 0.1,
            //                 0.7,
            //               ],
            //               colors: [
            //                 Colors.lightBlue.shade100,
            //                 const Color.fromRGBO(242, 249, 255, 1),
            //               ],
            //             ),
            //             borderRadius: BorderRadius.circular(10.0),
            //             image: const DecorationImage(
            //               image: AssetImage('images/calendar.png'),
            //               fit: BoxFit.fitWidth,
            //             )
            //         ),
            //       ),
            //     ],
            //     options: CarouselOptions(
            //       height: MediaQuery.of(context).size.height / 2,
            //       enlargeCenterPage: true,
            //       autoPlay: true,
            //       aspectRatio: 16/9,
            //       autoPlayCurve: Curves.fastOutSlowIn,
            //       enableInfiniteScroll: true,
            //       autoPlayAnimationDuration: const Duration(milliseconds: 900),
            //       viewportFraction: 0.9,
            //     ),
            // ),
            Image.asset(
              'images/logo.png',
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 40,
            ),
            const Text('Budget. Track. Remind',
              style: TextStyle(
                color: Color.fromRGBO(111, 146, 240, 1),
                // adds custom font
                // custom font is located in the pubspec.yaml file
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 80,
            ),
            const Text("it's time to wise up",
              style: TextStyle(
                color: Colors.grey,
                // adds custom font
                // custom font is located in the pubspec.yaml file
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 10.0,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.8,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 15,
                // Directionality allows for the placement of the arrow to be on the right side
                child: Directionality(
                  // text direction right to left
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 15.0,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.lightBlueAccent,
                      elevation: 4.0,
                      backgroundColor: const Color.fromRGBO(64, 91, 159, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Color.fromRGBO(64, 91, 159, 1)),
                      ),
                    ),
                    label: const Text('Get Started ',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text("Already have an account? Log in",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 8.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
