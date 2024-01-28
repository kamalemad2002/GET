import 'package:flutter/material.dart';
import 'package:flutter_app/login.dart';

void main() => runApp(MaterialApp(
  home: WelcomePage(),
),
);

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color(0xff2B475E),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image:  AssetImage("image/man-getting-award-writing_74855-5891.jpg"),
              fit: BoxFit.cover,
            )
        ),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container(
                      //   //alignment: Alignment.center,
                      //   width: 100,
                      //   height: 100,
                      //   decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //         image: AssetImage("image/get.jpg"),
                      //         fit: BoxFit.cover),
                      //     color: const Color.fromRGBO(160, 118, 87, 1),
                      //     borderRadius: BorderRadius.circular(70),
                      //   ),
                      // ),
                      // Image.asset(
                      //   'image/get.jpg',
                      //   height: 150,
                      //   width: 150,
                      // ),
                      SizedBox(height: 10),
                      // Text(
                      //   'GET',
                      //   style: TextStyle(
                      //     fontFamily: 'Pacifico',
                      //     fontSize: 45,
                      //     color: Colors.black,
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
                      SizedBox(height: 40),
                      ElevatedButton(

                        onPressed: () {
                          // Handle the "Welcome" button press
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Test()),
                          );

                          // print('Welcome Button Pressed');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text(
                            'Welcome',
                            style: TextStyle(
                                color: const Color.fromRGBO(215, 126, 55, 1.0),
                                fontSize: 20),

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
