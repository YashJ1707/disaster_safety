import 'package:disaster_safety/core/error/exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDatasource {
  Future<User> usernameLogin(String username, String passowrd);

  Future<User> googleLogin();

  Future<void> deleteUser(String username);

  Future<void> sendResetCode(String email);
  Future<void> confirmPasswordResetCode(
      String email, String code, String password);

  Future<void> logout();
  Future<UserCredential> signUp(String email, String password);
}

class AuthDatasourceImpl implements AuthDatasource {
  final FirebaseAuth fauth = FirebaseAuth.instance;
  @override
  Future<void> deleteUser(String username) async {
    try {
      final user = fauth.currentUser;
      user?.delete();
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.code.toString());
    }
  }

  @override
  Future<User> googleLogin() {
    // TODO: implement googleLogin
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    try {
      await fauth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? "Something went wrong");
    }
  }

  @override
  Future<void> sendResetCode(String email) async {
    try {
      await fauth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? "something went wrong");
    }
  }

  @override
  Future<void> confirmPasswordResetCode(
      String email, String code, String password) async {
    try {
      final response = await fauth.verifyPasswordResetCode(code);
      if (response == email) {
        await fauth.confirmPasswordReset(code: code, newPassword: password);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'expired-action-code':
          throw AuthException(message: "Code Expired");
        case 'invalid-action-code':
          throw AuthException(message: "Invalid code");
        case 'user-not-found':
          throw AuthException(message: "User not found");
        default:
          throw AuthException(message: e.message ?? "Something went wrong");
      }
    }
  }

  @override
  Future<UserCredential> signUp(String email, String password) async {
    try {
      final credential = await fauth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException(message: "The password provided is too weak;");
      } else if (e.code == 'email-already-in-use') {
        throw AuthException(
            message: "The account already exists for that email");
      } else {
        throw AuthException(message: e.message.toString());
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<User> usernameLogin(String email, String password) async {
    try {
      final credential = await fauth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        return credential.user!;
      } else {
        throw AuthException(message: "Something went wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException(message: "User not found");
      } else if (e.code == 'wrong-password') {
        throw AuthException(message: "Invalid Credentials");
      }
    } catch (e) {
      throw ServerException();
    }
    throw ServerException();
  }
}
