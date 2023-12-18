import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

void getUserData() async {
  print('Hello');
  await FirebaseFirestore.instance.collection('users').doc(
      FirebaseAuth.instance.currentUser!.uid).get().then((
      DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      store=documentSnapshot.data() as Map<String,dynamic>;
      print(store);
    }
  });
}
Map<String, dynamic> store= {};

class _ProfilePageState extends State<ProfilePage> {
  var myColor = const Color(0xff3d4ebc); //blue color
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String search="";
  final form = GlobalKey<FormState>();
  bool eyeObscure=true;
  User? user = FirebaseAuth.instance.currentUser;
  PageController pageController= PageController();
  List<UploadTask> uploadTasks = [];
  late UploadTask uploadTask;
  void initState(){
    getUserData();
    print('Inint');
    print(store['name']);
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    bool heightGreater = size.height > size.width ? true : false;
     return MaterialApp(
      home: Scaffold(
        // backgroundColor: Color(0xffffd460),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('image/scholar.png')),
              Text(
                '${store['name']}',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: Color(0xfff07b3f),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${store['rool']}',
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
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
                    '${store['email']}',
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
      ),
    );
  }
}
