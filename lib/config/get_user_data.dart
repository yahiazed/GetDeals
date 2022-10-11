import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../features/register/domain/entities/user_model.dart';

class GetUser {
  Future<UserModel> getCustomUserData(String uid) async {
    final modelRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJsonServiceProvider(),
        );
    UserModel userModel = await modelRef.get().then((value) => value.data()!);
    return userModel;
  }

  Future<dynamic> getUserData({UserModel? user}) async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      final modelRef = FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJsonServiceProvider(),
          );
      user = await modelRef.get().then((value) => value.data()!);
      return user;
    } else {
      return null;
    }
  }
}
