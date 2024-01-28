import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Services/DatabaseServices.dart';
class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String _bytesTransferred(TaskSnapshot snapshot) {
    double res = (snapshot.bytesTransferred / 1024.0) / 1000;
    double res2 = (snapshot.totalBytes / 1024.0) / 1000;
    return '${res.toStringAsFixed(2)}/${res2.toStringAsFixed(2)}';
  }
  var myColor = const Color(0xff3d4ebc); //blue color
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController _level = TextEditingController();

  String search = "";
  final form = GlobalKey<FormState>();
  bool eyeObscure = true;
  User? user = FirebaseAuth.instance.currentUser;
  PageController pageController = PageController();
  List<UploadTask> uploadTasks = [];
  late UploadTask uploadTask;
  String? level;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Choose a Chapter'),
                  content: DropdownButtonFormField<String>(
                    value: level,
                    onChanged: (newValue) {
                      setState(() {
                        level = newValue;
                      });
                      // Handle dropdown value change
                      print('Selected Chapter: $newValue');
                    },
                    items: [
                      const DropdownMenuItem<String>(
                        value: '1',
                        child: Text('Chapter 1'),
                      ),
                      const DropdownMenuItem<String>(
                        value: '2',
                        child: Text('Chapter 2'),
                      ),
                      const DropdownMenuItem<String>(
                        value: '3',
                        child: Text('Chapter 3'),
                      ),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Choose a Chapter',
                    ),
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop(
                        ); // Close the dialog
                      },
                      child: const Text('Cancel'),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (level != null) {
                          Navigator.of(context).pop();
                          String state =
                              await DatabaseServices().uploadFile(level!);
                          if (state == "updated") {
                            setState(() {
                              uploadTasks = [...uploadTasks, uploadTask];
                            });
                          }
                        }
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              });
        },
        backgroundColor: myColor,
        child: Icon(
          Icons.cloud_upload_outlined,
          size: 34,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 55,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Upload Files",
                    style: TextStyle(
                        color: myColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: uploadTasks.isEmpty
                    ? Center(
                        child: Text("No uploading files"),
                      )
                    : ListView.builder(
                        itemCount: uploadTasks.length,
                        itemBuilder: (context, index) => StreamBuilder(
                              stream: uploadTasks[index].snapshotEvents,
                              builder: (BuildContext context,
                                  AsyncSnapshot<TaskSnapshot> asyncSnapshot) {
                                Widget subtitle = Text("  ---");
                                TaskSnapshot? snap = asyncSnapshot.data;
                                TaskState? state = snap?.state;
                                if (asyncSnapshot.hasError) {
                                  if (asyncSnapshot.error
                                          is FirebaseException &&
                                      (asyncSnapshot.error as FirebaseException)
                                              .code ==
                                          'canceled') {
                                    subtitle = Text('Upload canceled.');
                                  } else {
                                    print(asyncSnapshot.error);
                                    subtitle = Text('Something went wrong.');
                                  }
                                } else if (snap != null) {
                                  subtitle = Text(
                                      ' ${_bytesTransferred(snap)} MB sent');
                                }

                                return ListTile(
                                  title: Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        //color: Colors.black,
                                        child:
                                            Image.asset("images/FilesIcon.png"),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              uploadTasks[index]
                                                  .snapshot
                                                  .ref
                                                  .name,
                                              style: TextStyle(
                                                color: myColor,
                                              ),
                                              maxLines: 1,
                                            ),
                                            subtitle,
                                          ],
                                        ),
                                      ),
                                      if (state == TaskState.running)
                                        IconButton(
                                          icon: Icon(
                                            Icons.pause,
                                            color: myColor,
                                          ),
                                          onPressed: () =>
                                              uploadTasks[index].pause(),
                                        ),
                                      if (state == TaskState.running)
                                        IconButton(
                                          icon: Icon(
                                            Icons.cancel,
                                            color: myColor,
                                          ),
                                          onPressed: () =>
                                              uploadTasks[index].cancel(),
                                        ),
                                      if (state == TaskState.paused)
                                        IconButton(
                                          icon: Icon(
                                            Icons.play_arrow,
                                            color: myColor,
                                          ),
                                          onPressed: () =>
                                              uploadTasks[index].resume(),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
