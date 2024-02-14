import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_safety/core/error/exception.dart';
import 'package:disaster_safety/features/auth/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class DbDatasource {
  Future<void> addUserData(UserModel user, UserCredential credential);

  Future<void> removeData(String uid);

  Future<UserModel> getUserData({required String uid});

  Future<void> updateUserData(UserModel user);
}

class DbDatasourceImpl implements DbDatasource {
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection("users");
  @override
  Future<void> addUserData(UserModel user, UserCredential credential) async {
    try {
      final Map<String, dynamic> userMap = user.toMap();
      String uid = credential.user!.uid;
      userMap.update("id", (value) => credential.user?.uid);
      userMap.update("id", (value) => credential.user?.uid);
      await userRef.doc(uid).set({...userMap}).catchError(
          (error) => throw DatabaseException(error.toString()));
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> removeData(String uid) async {
    try {
      await userRef.doc(uid).delete();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<UserModel> getUserData({required String uid}) async {
    try {
      final snapshot = await userRef.doc(uid).get();
      if (snapshot.exists) {
        final Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
        final UserModel user = UserModel.fromMap(data);
        return user;
      } else {
        throw DatabaseException("Data does not exist");
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateUserData(UserModel user) async {
    try {
      await userRef.doc(user.id).set(user.toMap());
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
