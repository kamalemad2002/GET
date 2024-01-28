import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/try/studentFiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/try/test.dart';
import 'second_page.dart';
import 'package:flutter_app/Services/AuthServices.dart';


void main() {
  runApp(MaterialApp(
    title: 'Hello flutter',
    home: HomePage(),
  ));
}

/// Represents Homepage for Navigation
class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List subjects = [];
  List Doctors = [];

  Future<List> getUserSubjects() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('enrollment')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    Map<String, dynamic> store =
        documentSnapshot.data() as Map<String, dynamic>;
    subjects = store['subjects'];
    getDoctorid(subjects);
    return subjects;
  }

  void getDoctorid(List subject) {
    String docID;
    for (int i = 0; i < subjects.length; i++) {
      switch (subject[i]) {
        case 'cost':
          docID = 'zWkvkDalblRoUN0MkW5ZWZbfxES2';
          break;
        case 'institution':
          docID = 'dqYqjSn3HrbUYecA75wLpVTlV6z1';
          break;
        default:
          docID = 'test';
      }
      Doctors.add(docID);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff2B475E),
          title: const Text('BIS LEVEL 2'),
          foregroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined)),
          ],
        ),
        drawer: const NavigationDrawer(children: [
          NavigationDrawerDestination(
              icon: Icon(Icons.home), label: Text('Home')),
          NavigationDrawerDestination(
              icon: Icon(Icons.notifications), label: Text('Notification')),
          NavigationDrawerDestination(
              icon: Icon(Icons.settings), label: Text('Settings')),
        ]),
        body: FutureBuilder(
          future: getUserSubjects(),
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting)
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            if (snapshot.hasError)
              return Center(
                child: Text('Error is : ${snapshot.error}'),
              );
            else
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: subjects.length + 1, // Add 1 for the static button
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  if (index == subjects.length) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Aboutme()));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          color: Colors.blue,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            "About Me",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  } else {
                    // This is a dynamic item from the FutureBuilder
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => chapters(
                                  docID: Doctors[index],
                                )));
                        // Write your code here
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          color: Color.fromRGBO(230, 57, 70, 0.9),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            "${subjects[index]}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }
                },
              );
          },
        ));
  }
}

class chapters extends StatelessWidget {
  final String docID;
  const chapters({super.key, required this.docID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COST'),
      ),
      body: GridView.count(
        // primary: false,
        padding: const EdgeInsets.all(12),
        childAspectRatio: (20 / 10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 1,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => pdfpage(
                          DocID: docID,
                          chapter: '1',
                        )),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.deepPurpleAccent,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("Unit 1"),
              ),
            ),
          ),
          /* Button 2*/
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => pdfpage(
                          DocID: docID,
                          chapter: '2',
                        )),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.greenAccent,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("Unit 2"),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => pdfpage(
                          DocID: docID,
                          chapter: '3',
                        )),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.redAccent,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("Unit 3"),
              ),
            ),
          ),
        ],
      ),
    );
    //);
  }
}
