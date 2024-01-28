import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(MaterialApp(
    title: 'hi!',
    home: HPage(),
  ));
}

/// Represents Homepage for Navigation
class HPage extends StatefulWidget {
  @override
  _HPage createState() => _HPage();
}

void getUserData() async {
  print('Hello');
  await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      store = documentSnapshot.data() as Map<String, dynamic>;
      // print(store);
    }
  });
}

Map<String, dynamic> store = {};

class _HPage extends State<HPage> {
  @override
  void initState() {
    getUserData();
    super.initState();
    // String? myName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello bis!')),
      body: SfPdfViewer.network(
        'https://drive.google.com/uc?export=view&id=1AkVLYb4S1CnUJF7i8Nj1Ee3Cs_ZMf9Xp',
        //key: _pdfViewerKey,
      ),
    );
  }
}

class AdLearn extends StatelessWidget {
  const AdLearn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SAD II'),
      ),
      body: SfPdfViewer.network(
        '',

        //key: _pdfViewerKey,
      ),
    );
    //);
  }
}

class Aboutme extends StatefulWidget {
  @override
  State<Aboutme> createState() => _AboutmeState();
}

class _AboutmeState extends State<Aboutme> {
  Future<Map<String, dynamic>> getUserData() async {
    Map<String, dynamic> store = {};

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        store = documentSnapshot.data() as Map<String, dynamic>;
      }
    });
    return store;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error while loading : ${snapshot.error}'),
            );
          } else {
            Map<String, dynamic> data = snapshot.data!;
            return Scaffold(
              backgroundColor: Color(0xffffd460),
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage('image/scholar.png')),
                    Text(
                      '${data['name']}',
                      style: TextStyle(
                          fontFamily: 'Pacifico',
                          color: Color(0xfff07b3f),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${data['rool']}',
                      style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          letterSpacing: 2.5,
                          color: Color(0xfff07b3f),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                      width: 150,
                      child: Divider(
                        color: Color(0xfff07b3f),
                      ),
                    ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: Color(0xfff07b3f),
                        ),
                        title: Text(
                          '+20 1201451498',
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            color: Color(0xfff07b3f),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 25),
                      child: ListTile(
                        leading: Icon(
                          Icons.email,
                          color: Color(0xfff07b3f),
                        ),
                        title: Text(
                          '${data['email']}',
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            color: Color(0xfff07b3f),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                      width: 150,
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 25),
                      child: ListTile(
                        leading: Icon(
                          Icons.account_tree_outlined,
                          color: Color(0xfff07b3f),
                        ),
                        title: Text(
                          'bis@edu.au.eg',
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            color: Color(0xfff07b3f),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    // MaterialButton(onPressed: (){

                    //   getUserData();
                    // },child: Text('Print date'),)
                  ],
                ),
              ),
            );
          }
        });
  }
}
