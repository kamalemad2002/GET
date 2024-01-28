import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServices {
  User? user = FirebaseAuth.instance.currentUser;
  late UploadTask uploadTask;
  CollectionReference userFiles =
      FirebaseFirestore.instance.collection('users');

  getPDFbyDoctorId(String ID) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc('$ID')
        .collection('userFiles')
        .get();
    print(querySnapshot);
  }

  Future getUserInfo() async {
    return await userFiles.doc(user!.uid).get().then((value) {
      if (value.exists) {
        return value.data();
      } else {
        userFiles.doc(user!.uid).set({
          "email": user!.email,
          "uid": user!.uid,
          "profileUrl": null,
          "name": user!.displayName
        }).whenComplete(() {
          return value.data();
        });
      }
    });
  }

  Future uploadFile(String level) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    //upload file to users account
    // var kk = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(user!.uid)
    //     .get()
    //     .then(();
    if (result != null) {
      PlatformFile f = result.files.single;
      File file = File(f.path.toString());
      String filename = basename(file.path);
      String? fileType = f.extension;
      Reference storage = FirebaseStorage.instance
          .ref()
          .child('users/' + user!.uid + '/userFiles/' + filename);
      uploadTask = storage.putFile(file);

      uploadTask.whenComplete(() async {
        String url = await storage.getDownloadURL();

        await userFiles
            .doc(user!.uid)
            .collection('userFiles')
            .doc(filename)
            .set({
          'name': filename,
          'type': fileType,
          'url': url,
          'time': Timestamp.now(),
          'chapter': level
        });
      });
      return "updated";
    } else {
      return "cancelled";
    }
  }

  Future deleteDoc(String filename) async {
    Reference storage = FirebaseStorage.instance
        .ref()
        .child('users/' + user!.uid + '/userFiles/' + filename);
    await storage.delete();
    await userFiles
        .doc(user!.uid)
        .collection('userFiles')
        .doc(filename)
        .delete();
  }
// exhaustinggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
}
