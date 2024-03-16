import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nexus/core/network/client.dart';
import 'package:path/path.dart' as path;

abstract class AuthenticationRemoteDatasource {
  Future<dynamic> login(Map<String, dynamic> map);
  Future<dynamic> loginWithGoogle(AuthCredential credential);
  Future<dynamic> register(Map<String, dynamic> map);
  Future<dynamic> registerWithGoogle(AuthCredential credential);
  Future<dynamic> read(String col, String doc);
  Future<dynamic> write(
    String col,
    String doc,
    Map<String, dynamic> data, {
    bool useID = false,
  });
  Future<void> logout();
  Future<bool> isAuth();
  Future<String> upload(File file);
  Future<QuerySnapshot<Map<String, dynamic>>> listen(String col, bool useId);
  Future<dynamic> update(
    String doc,
    Map<String, dynamic> data,
  );
}

@LazySingleton(as: AuthenticationRemoteDatasource)
class AuthenticationRemoteDatasourceImpl
    extends AuthenticationRemoteDatasource {
  AuthenticationRemoteDatasourceImpl({
    required this.network,
    required this.cloudinary,
  });

  final MyNetwork network;
  final CloudinaryPublic cloudinary;

  @override
  Future login(Map<String, dynamic> map) async {
    return (await network.signIn(map));
  }

  @override
  Future register(Map<String, dynamic> map) async {
    return (await network.signUp(map));
  }

  @override
  Future registerWithGoogle(AuthCredential credential) async {
    return (await network.signUpWithGoogle(credential));
  }

  @override
  Future loginWithGoogle(AuthCredential credential) async {
    return (await network.signUpWithGoogle(credential));
  }

  @override
  Future read(String col, String doc) async {
    return await network.read(col, doc);
  }

  @override
  Future write(
    String col,
    String doc,
    Map<String, dynamic> data, {
    bool useID = false,
  }) async {
    Logger().d('$col $doc $data $useID');
    return await network.write(col, doc, data, useID: useID);
  }

  @override
  Future update(
    String doc,
    Map<String, dynamic> data,
  ) async {
    Logger().d(' $doc $data');
    return await network.update(
      doc,
      data,
    );
  }

  @override
  Future<void> logout() async => await network.logout();

  @override
  Future<bool> isAuth() {
    return network.isAuth();
  }

  @override
  Future<String> upload(File file) async {
    // var res = await cloudinary.uploadFile(CloudinaryFile.fromFile(file.path));

    // return res.secureUrl;
    String fileName = path.basename(file.path);
    TaskSnapshot storageReference =
        await FirebaseStorage.instance.ref().child(fileName).putFile(file);
    String url = await storageReference.ref.getDownloadURL();
    return url;
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> listen(
      String col, bool useId) async {
    return await network.listen(col, useID: useId);
  }
}
