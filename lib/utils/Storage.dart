import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Storage {
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future uploadFile(String fileName, String filePath) async {
    File file = File(filePath);
    try{
      var list = await storage.ref('profilePic').listAll();
      var exist = true;
      while (exist){
        exist = false;
        list.items.forEach((element) {
          if (element.name == fileName){
            exist = true;
          }
        });
        if (exist){
          fileName = fileName.substring(0,fileName.indexOf(".")) + Random().nextInt(100000).toString() + fileName.substring(fileName.indexOf("."));
        }
      }
      var res = await storage.ref('profilePic/$fileName').putFile(file);
      return res.ref.getDownloadURL();
    }
    on firebase_core.FirebaseException catch (e){
      print(e);
    }
  }
}