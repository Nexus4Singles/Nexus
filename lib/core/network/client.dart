import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:nexus/core/constant.dart';
import 'package:uuid/uuid.dart';

abstract class MyNetwork {
  Future<dynamic> get();
  Future<dynamic> post(Map<String, dynamic> map);
  Future<dynamic> signIn(Map<String, dynamic> map);
  Future<dynamic> signInWithGoogle(AuthCredential credential);
  Future<dynamic> signUp(Map<String, dynamic> map);
  Future<dynamic> signUpWithGoogle(AuthCredential credential);
  Future<dynamic> read(String collection, String doc);
  Future<dynamic> listen(String col, {bool useID = false});
  Future<dynamic> write(
    String collection,
    String doc,
    Map<String, dynamic> data, {
    bool useID = false,
  });
  Future<dynamic> update(
    String doc,
    Map<String, dynamic> data,
  );
  Future<void> logout();
  Future<bool> isAuth();

  Future<User?> exposeAuth();
  Future<FirebaseFirestore> exposefirestore();
}

@LazySingleton(as: MyNetwork)
class MyNetworkImpl extends MyNetwork {
  MyNetworkImpl({
    required this.auth,
    required this.uuid,
    required this.firestore,
  });

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final Uuid uuid;

  @override
  Future get() async {}

  @override
  Future post(Map<String, dynamic> map) async {}

  @override
  Future signIn(Map<String, dynamic> map) async {
    var response = await auth.signInWithEmailAndPassword(
      email: map[kEMAIL],
      password: map[kPASSWORD],
    );

    return response.user!;
  }

  @override
  Future signUp(Map<String, dynamic> map) async {
    var response = await auth.createUserWithEmailAndPassword(
      email: map[kEMAIL],
      password: map[kPASSWORD],
    );

    return response.user;
  }

  @override
  Future signUpWithGoogle(AuthCredential credential) async {
    var response = await auth.signInWithCredential(credential);

    return response.user;
  }

  @override
  Future signInWithGoogle(AuthCredential credential) async {
    var response = await auth.signInWithCredential(credential);

    return response.user;
  }

  @override
  Future read(String collection, String doc, {bool useID = false}) async {
    late DocumentSnapshot<Map<String, dynamic>> data;
    var user = auth.currentUser!;

    if (useID) {
      data = await firestore
          .collection(kUSER_KEY)
          .doc(user.uid)
          .collection(collection)
          .doc(uuid.v1())
          .get();
    } else {
      data = await firestore.collection(kUSER_KEY).doc(user.uid).get();
    }

    return data.data();
  }

  @override
  Future write(
    String collection,
    String doc,
    Map<String, dynamic> data, {
    bool useID = false,
  }) async {
    if (useID) {
      var user = auth.currentUser;

      var id = uuid.v1();
      data.update(kID, (_) => id);

      return await firestore
          .collection('DC_USER')
          .doc(user!.uid)
          .collection(collection)
          .doc(id)
          .set(data);
    } else {
      return await firestore.collection('DC_USER').doc(doc).set(data);
    }
  }

  @override
  Future update(String doc, Map<String, dynamic> data) async {
    var user = auth.currentUser;

    return await firestore.collection('DC_USER').doc(user!.uid).update(data);
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  @override
  Future<bool> isAuth() async {
    return auth.currentUser != null;
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> listen(
    String col, {
    bool useID = false,
  }) async {
    if (useID) {
      var user = auth.currentUser;

      var d = await firestore
          .collection('DC_USER')
          .doc(user!.uid)
          .collection(col)
          .get();

      return d;
    } else {
      return firestore.collection('DC_USER').get();
    }
  }

  @override
  Future<User?> exposeAuth() async {
    return Future.value(auth.currentUser);
  }

  @override
  Future<FirebaseFirestore> exposefirestore() async {
    return Future.value(firestore);
  }
}
