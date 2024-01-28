import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_app/Services/DatabaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';

class pdfpage extends StatefulWidget {
  final String DocID;
  final String chapter;

  const pdfpage({super.key, required this.DocID, required this.chapter});

  @override
  _pdfpageState createState() => _pdfpageState();
}

class _pdfpageState extends State<pdfpage> {
  ReceivePort _port = ReceivePort();
  String? DoctorID;

  List types = ['jpg', 'jpeg', 'tif', 'tiff', 'bmp', 'gif', 'png', 'docx'];

  // void getUserData() async {
  //   print('Hello');
  //   await FirebaseFirestore.instance.collection('users').doc(
  //       FirebaseAuth.instance.currentUser!.uid).get().then((
  //       DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       store=documentSnapshot.data() as Map<String,dynamic>;
  //       print(store);
  //     }
  //   });
  // }
  // Map<String, dynamic> store= {};

  var myColor = const Color(0xff3d4ebc);
  User? user = FirebaseAuth.instance.currentUser;

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      String? id = data[0];
      DownloadTaskStatus? status = data[1];
      int? progress = data[2];
    });
  }

  Future<PDFDocument> loadPDFDocument(String url) async {
    return await PDFDocument.fromURL(url);
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  String getImageIcon(type) {
    return "image/FilesIcon.png";
  }

  bool isImage(String type) {
    if (types.contains(type)) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              //AppBar
              height: 55,
              width: double.infinity,

              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                "root/",
                                style: TextStyle(color: myColor, fontSize: 24),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Directory"),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        //TODO: copy button onTap
                      },
                      icon: Icon(
                        Icons.copy,
                        color: myColor,
                      ))
                ],
              ),
            ),
            Expanded(
                child: StreamBuilder(
              stream: DatabaseServices()
                  .userFiles
                  .doc('${widget.DocID}')
                  .collection('userFiles')
                  .where('chapter', isEqualTo: '${widget.chapter}')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('Loading'));
                } else if (snapshot.data!.docs.isEmpty) {
                  //print(snapshot.data.documents);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'image/BlueCloud.png',
                        height: 150,
                      ),
                      Text("No file is your cloud drive"),
                    ],
                  );
                }
                return ListView(
                    physics: BouncingScrollPhysics(),
                    children: snapshot.data!.docs
                        .map((doc) => ListTile(
                              title: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    //color: Colors.black,
                                    child: isImage(doc['type'])
                                        ? Image.network(doc['url'],
                                            fit: BoxFit.cover)
                                        : Image.asset(
                                            getImageIcon(doc["type"])),
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
                                          doc['name'],
                                          style: TextStyle(
                                            color: myColor,
                                          ),
                                          maxLines: 1,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            final String dir =
                                                "/storage/emulated/0/Download";
                                            final String filedir =
                                                "$dir/${doc['name']}";
                                            if (await File(filedir).exists()) {
                                              Fluttertoast.showToast(
                                                msg:
                                                    "File already exists in download folder",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                              );
                                            } else {
                                              //TODO: bug fix
                                              /*final status = await Permission
                                                  .storage
                                                  .request();
                                              if (status.isGranted) {

                                                await FlutterDownloader.enqueue(
                                                  url: doc['url'],
                                                  savedDir: dir,
                                                  showNotification: true,
                                                  openFileFromNotification:
                                                  true,
                                                  fileName: doc['name'],
                                                );
                                              }*/
                                            }
                                          },
                                          child: Text(
                                            "Download",
                                            style: TextStyle(
                                                color: Colors.blue[700],
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  MaterialButton(
                                    child: Text('View'),
                                    onPressed: () async {
                                      if (doc['type'] == 'pdf') {
                                        // Load the PDF document
                                        PDFDocument pdfDocument =
                                            await loadPDFDocument(doc['url']);

                                        // Navigate to the PDF viewer screen
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PDFViewerScreen(
                                              pdfDocument: pdfDocument,
                                            ),
                                          ),
                                        );
                                      } else {
                                        // Handle other types or show an error message
                                      }
                                    },
                                  )
                                ],
                              ),
                            ))
                        .toList());
              },
            )),
          ],
        ),
      ),
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final PDFDocument? pdfDocument;

  PDFViewerScreen({required this.pdfDocument});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        backgroundColor: Colors.green,
      ),
      body: PDFViewer(document: pdfDocument!, lazyLoad: true),
    );
  }
}
