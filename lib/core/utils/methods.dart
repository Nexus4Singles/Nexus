import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';

Future<String> upload(File file) async {
  String fileName = path.basename(file.path);
  TaskSnapshot storageReference =
      await FirebaseStorage.instance.ref().child(fileName).putFile(file);
  String url = await storageReference.ref.getDownloadURL();
  return url;
}
