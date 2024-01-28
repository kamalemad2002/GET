import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_app/textFormField.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/Pages/HomePage.dart';

void main() => runApp(MaterialApp(
      home: Test(),
    ));

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

// bool validateuser(List<Map<String, String>> test, String mail, String password) {
//   for (var user in test) {
//     if (user['mail'] == mail && user['pass'] == password) {
//       return true;
//     }
//   }
//   return false;
// }

class _TestState extends State<Test> {
  bool emailFound=false;
  bool isLoading = false;
  GlobalKey<FormState> formstate = GlobalKey();
  Function(String)? onChanged;
  String? email, password;

//   List<Map<String, String>> users = [
//     {'mail': 'kamal@gmail.com', 'pass': '12345'},
//     {'mail': 'admin@gmail.com', 'pass': '12345'},
//     {'mail': 'admin', 'pass': 'admin1'},
//     {'mail': 'admin2', 'pass': 'admin2'}
//   ];
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController emailController = TextEditingController();
// TextEditingController passwordController = TextEditingController();
//   GlobalKey<FormState> secondkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
            image:  AssetImage("image/login.jpg"),
              fit: BoxFit.cover,
            )
          ),
          margin: EdgeInsets.all(0),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 80),
                    child: Column(
                      children: [
                        // Image(image: AssetImage('image/scholar.png')),

                        Center(
                          child: Container(
                            //alignment: Alignment.center,
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("image/get.jpg"),
                                  fit: BoxFit.cover),
                              color: const Color.fromRGBO(160, 118, 87, 1),
                              borderRadius: BorderRadius.circular(70),
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        Text(
                          'Welcome back',
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 40,
                            color: const Color.fromRGBO(160, 118, 87, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Form(
                    key: formstate,
                    child: Column(
                      children: [

                        Center(
                          child: Text('  E_Mail:',
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: const Color.fromRGBO(160, 118, 87, 1),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          height: 10,
                        ),
                        textFormField(
                          hidden: false,
                          onChanged: (data) {
                            email = data;
                          },

                          labelText: 'username',
                          hintText: 'username',
                        ),
                        // TextFormField(
                        //
                        //   onChanged: (value) {
                        //     email = value;
                        //   },
                        //   // controller: emailController,
                        //   validator: (value) {
                        //     if (value!.isEmpty) return 'Required';
                        //     // if (!validateuser(
                        //     //     users, emailController.text, passwordController.text))
                        //     return 'Check Email';
                        //   },
                        //   decoration: InputDecoration(
                        //       labelText: 'Username',
                        //       hintText: 'Username',
                        //       border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(20))),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        // TextFormField(
                        //     onChanged: (value) {
                        //       password = value;
                        //
                        //     },
                        //     // controller: passwordController,
                        //     obscureText: true,
                        //     validator: (value) {
                        //       if (value!.isEmpty) return 'Required';
                        //       // if (!validateuser(
                        //       //     users, emailController.text, passwordController.text))
                        //       return 'Check password';
                        //     },
                        //     decoration: InputDecoration(
                        //         labelText: 'Password',
                        //         hintText: 'Password',
                        //         border: OutlineInputBorder(
                        //             borderRadius: BorderRadius.circular(
                        //                 20)))),

                        Container(
                          height: 5,
                        ),
                        Center(
                          child: Text('Password',
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: const Color.fromRGBO(160, 118, 87, 1),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          height: 10,
                        ),
                        textFormField(
                          hidden: true,
                          onChanged: (data) {
                            password = data;
                          },
                          labelText: 'password',
                          hintText: 'password',
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),


                        
                        MaterialButton(
                          minWidth: 150,
                          height: 45,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: const Color.fromRGBO(160, 118, 87, 1),
                          hoverColor: Colors.black,
                          child: Text('Login',
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: const Color.fromRGBO(
                                      255, 255, 255, 1),
                                  fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            if (formstate.currentState!.validate()) {
                              // print('Siiiiu');
                              isLoading = true;
                              setState(() {});
                              try {
                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: email!, password: password!);
                                emailFound=true;
                                route();
                              } on FirebaseAuthException catch (e) {
                                print('user-not-found');

                                if (e.code == 'user-not-found') {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Something went wrong',
                                    desc:
                                    'Email not found',
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                  ).show();
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Something went wrong',
                                    desc:
                                    'Wrong passord',
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                  ).show();
                                  print(
                                      'Wrong password provided for that user.');
                                }
                              }
                              if(!emailFound)
                                {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Something went wrong',
                                    desc:
                                    'Email or password are not collect',
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                  ).show();
                                }
                              emailFound=false;
                              isLoading = false;
                              setState(() {});
                            }
                          },
                          // child: Text(
                          //   'Login',
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.bold, fontSize: 20),
                          // ),
                        ),
                        Container(
                          // margin: EdgeInsets.only(left: 207),
                          alignment: Alignment.center,
                          child: Text('Or Login with : ',
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            width: 300,
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  child: IconButton(
                                    onPressed: () => print("Facebook"),
                                    icon: Icon(Icons.facebook),
                                    iconSize: 50,
                                    color: Colors.blue,
                                  ),
                                ),
                                Container(margin: EdgeInsets.only(right: 33), width: 42 , height: 42, child: Image(image: AssetImage('image/gogle2.png'))),
                                Container( width: 42 , height: 42, child: Image(image: AssetImage('image/xtwitter.jpg'))),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('rool') == "student") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePagee(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }
}
