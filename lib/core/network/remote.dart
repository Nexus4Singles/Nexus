import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

import 'client.dart';

abstract class GeneralRemote {
  // todo: change them later
  Future<User?> firebaseUser();
  Future<FirebaseFirestore> firebaseFirestore();
  Future<String> upload(File file);
}

@LazySingleton(as: GeneralRemote)
class GeneralRemoteImpl extends GeneralRemote {
  GeneralRemoteImpl({
    required this.network,
  });

  final MyNetwork network;

  @override
  Future<FirebaseFirestore> firebaseFirestore() async {
    return await network.exposefirestore();
  }

  @override
  Future<User?> firebaseUser() async {
    return await network.exposeAuth();
  }

  @override
  Future<String> upload(File file) async {
    String fileName = path.basename(file.path);
    TaskSnapshot storageReference =
        await FirebaseStorage.instance.ref().child(fileName).putFile(file);
    String url = await storageReference.ref.getDownloadURL();
    return url;
  }
}
