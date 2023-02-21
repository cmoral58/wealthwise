import 'package:flutter/material.dart';
import 'package:wealthwise/login.dart';
import 'package:wealthwise/register.dart';
import 'package:carousel_slider/carousel_slider.dart';

// current images used are from freepik.com (image by redgreystock on freepik)

// TODO: improve welcome screen
// TODO: add logic so that this screen only shows up for new users

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              height: 50.0,
            ),
            CarouselSlider(
                items: [
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: const [
                            0.1,
                            0.7,
                          ],
                          colors: [
                            Colors.lightBlue.shade100,
                            Color.fromRGBO(242, 249, 255, 1),
                          ],
                        ),
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: AssetImage('images/save.png'),
                        fit: BoxFit.fitWidth,
                      )
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: const [
                            0.1,
                            0.7,
                          ],
                          colors: [
                            Colors.lightBlue.shade100,
                            Color.fromRGBO(242, 249, 255, 1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        image: const DecorationImage(
                          image: AssetImage('images/invest.png'),
                          fit: BoxFit.fitWidth,
                        )
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: const [
                            0.1,
                            0.7,
                          ],
                          colors: [
                            Colors.lightBlue.shade100,
                            Color.fromRGBO(242, 249, 255, 1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        image: const DecorationImage(
                          image: AssetImage('images/calendar.png'),
                          fit: BoxFit.fitWidth,
                        )
                    ),
                  ),
                ], 
                options: CarouselOptions(
                  height: 420.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16/9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 900),
                  viewportFraction: 0.9,
                ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 20.0,
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
            const SizedBox(
              width: double.infinity,
              height: 10.0,
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
            const SizedBox(
              width: double.infinity,
              height: 200.0,
            ),
            Center(
              child: SizedBox(
                width: 200.0,
                height: 50.0,
                // Directionality allows for the placement of the arrow to be on the right side
                child: Directionality(
                  // text direction right to left
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                        Icons.arrow_back,
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
