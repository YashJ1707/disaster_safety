// Mocks generated by Mockito 5.4.4 from annotations
// in disaster_safety/test/features/auth/data/repository/auth_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:cloud_firestore/cloud_firestore.dart' as _i3;
import 'package:disaster_safety/features/auth/data/datasource/auth_datasource.dart'
    as _i5;
import 'package:disaster_safety/features/auth/data/datasource/db_datasource.dart'
    as _i7;
import 'package:disaster_safety/features/auth/data/model/user_model.dart'
    as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i2;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart'
    as _i9;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeFirebaseAuth_0 extends _i1.SmartFake implements _i2.FirebaseAuth {
  _FakeFirebaseAuth_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUser_1 extends _i1.SmartFake implements _i2.User {
  _FakeUser_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUserCredential_2 extends _i1.SmartFake
    implements _i2.UserCredential {
  _FakeUserCredential_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCollectionReference_3<T extends Object?> extends _i1.SmartFake
    implements _i3.CollectionReference<T> {
  _FakeCollectionReference_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUserModel_4 extends _i1.SmartFake implements _i4.UserModel {
  _FakeUserModel_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUserMetadata_5 extends _i1.SmartFake implements _i2.UserMetadata {
  _FakeUserMetadata_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMultiFactor_6 extends _i1.SmartFake implements _i2.MultiFactor {
  _FakeMultiFactor_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIdTokenResult_7 extends _i1.SmartFake implements _i2.IdTokenResult {
  _FakeIdTokenResult_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeConfirmationResult_8 extends _i1.SmartFake
    implements _i2.ConfirmationResult {
  _FakeConfirmationResult_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthDatasourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthDatasourceImpl extends _i1.Mock
    implements _i5.AuthDatasourceImpl {
  MockAuthDatasourceImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.FirebaseAuth get fauth => (super.noSuchMethod(
        Invocation.getter(#fauth),
        returnValue: _FakeFirebaseAuth_0(
          this,
          Invocation.getter(#fauth),
        ),
      ) as _i2.FirebaseAuth);

  @override
  _i6.Future<void> deleteUser(String? username) => (super.noSuchMethod(
        Invocation.method(
          #deleteUser,
          [username],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<_i2.User> googleLogin() => (super.noSuchMethod(
        Invocation.method(
          #googleLogin,
          [],
        ),
        returnValue: _i6.Future<_i2.User>.value(_FakeUser_1(
          this,
          Invocation.method(
            #googleLogin,
            [],
          ),
        )),
      ) as _i6.Future<_i2.User>);

  @override
  _i6.Future<void> logout() => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> sendResetCode(String? email) => (super.noSuchMethod(
        Invocation.method(
          #sendResetCode,
          [email],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> confirmPasswordResetCode(
    String? email,
    String? code,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #confirmPasswordResetCode,
          [
            email,
            code,
            password,
          ],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<_i2.UserCredential> signUp(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #signUp,
          [
            email,
            password,
          ],
        ),
        returnValue: _i6.Future<_i2.UserCredential>.value(_FakeUserCredential_2(
          this,
          Invocation.method(
            #signUp,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i6.Future<_i2.UserCredential>);

  @override
  _i6.Future<_i2.User> usernameLogin(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #usernameLogin,
          [
            email,
            password,
          ],
        ),
        returnValue: _i6.Future<_i2.User>.value(_FakeUser_1(
          this,
          Invocation.method(
            #usernameLogin,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i6.Future<_i2.User>);
}

/// A class which mocks [DbDatasourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockDbDatasourceImpl extends _i1.Mock implements _i7.DbDatasourceImpl {
  MockDbDatasourceImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.CollectionReference<Object?> get userRef => (super.noSuchMethod(
        Invocation.getter(#userRef),
        returnValue: _FakeCollectionReference_3<Object?>(
          this,
          Invocation.getter(#userRef),
        ),
      ) as _i3.CollectionReference<Object?>);

  @override
  _i6.Future<void> addUserData(
    _i4.UserModel? user,
    _i2.UserCredential? credential,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addUserData,
          [
            user,
            credential,
          ],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> removeData(String? uid) => (super.noSuchMethod(
        Invocation.method(
          #removeData,
          [uid],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<_i4.UserModel> getUserData({required String? uid}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserData,
          [],
          {#uid: uid},
        ),
        returnValue: _i6.Future<_i4.UserModel>.value(_FakeUserModel_4(
          this,
          Invocation.method(
            #getUserData,
            [],
            {#uid: uid},
          ),
        )),
      ) as _i6.Future<_i4.UserModel>);

  @override
  _i6.Future<void> updateUserData(_i4.UserModel? user) => (super.noSuchMethod(
        Invocation.method(
          #updateUserData,
          [user],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}

/// A class which mocks [UserCredential].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserCredential extends _i1.Mock implements _i2.UserCredential {
  MockUserCredential() {
    _i1.throwOnMissingStub(this);
  }
}

/// A class which mocks [User].
///
/// See the documentation for Mockito's code generation for more information.
class MockUser extends _i1.Mock implements _i2.User {
  MockUser() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get emailVerified => (super.noSuchMethod(
        Invocation.getter(#emailVerified),
        returnValue: false,
      ) as bool);

  @override
  bool get isAnonymous => (super.noSuchMethod(
        Invocation.getter(#isAnonymous),
        returnValue: false,
      ) as bool);

  @override
  _i2.UserMetadata get metadata => (super.noSuchMethod(
        Invocation.getter(#metadata),
        returnValue: _FakeUserMetadata_5(
          this,
          Invocation.getter(#metadata),
        ),
      ) as _i2.UserMetadata);

  @override
  List<_i2.UserInfo> get providerData => (super.noSuchMethod(
        Invocation.getter(#providerData),
        returnValue: <_i2.UserInfo>[],
      ) as List<_i2.UserInfo>);

  @override
  String get uid => (super.noSuchMethod(
        Invocation.getter(#uid),
        returnValue: _i8.dummyValue<String>(
          this,
          Invocation.getter(#uid),
        ),
      ) as String);

  @override
  _i2.MultiFactor get multiFactor => (super.noSuchMethod(
        Invocation.getter(#multiFactor),
        returnValue: _FakeMultiFactor_6(
          this,
          Invocation.getter(#multiFactor),
        ),
      ) as _i2.MultiFactor);

  @override
  _i6.Future<void> delete() => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<String?> getIdToken([bool? forceRefresh = false]) =>
      (super.noSuchMethod(
        Invocation.method(
          #getIdToken,
          [forceRefresh],
        ),
        returnValue: _i6.Future<String?>.value(),
      ) as _i6.Future<String?>);

  @override
  _i6.Future<_i2.IdTokenResult> getIdTokenResult(
          [bool? forceRefresh = false]) =>
      (super.noSuchMethod(
        Invocation.method(
          #getIdTokenResult,
          [forceRefresh],
        ),
        returnValue: _i6.Future<_i2.IdTokenResult>.value(_FakeIdTokenResult_7(
          this,
          Invocation.method(
            #getIdTokenResult,
            [forceRefresh],
          ),
        )),
      ) as _i6.Future<_i2.IdTokenResult>);

  @override
  _i6.Future<_i2.UserCredential> linkWithCredential(
          _i2.AuthCredential? credential) =>
      (super.noSuchMethod(
        Invocation.method(
          #linkWithCredential,
          [credential],
        ),
        returnValue: _i6.Future<_i2.UserCredential>.value(_FakeUserCredential_2(
          this,
          Invocation.method(
            #linkWithCredential,
            [credential],
          ),
        )),
      ) as _i6.Future<_i2.UserCredential>);

  @override
  _i6.Future<_i2.UserCredential> linkWithProvider(_i9.AuthProvider? provider) =>
      (super.noSuchMethod(
        Invocation.method(
          #linkWithProvider,
          [provider],
        ),
        returnValue: _i6.Future<_i2.UserCredential>.value(_FakeUserCredential_2(
          this,
          Invocation.method(
            #linkWithProvider,
            [provider],
          ),
        )),
      ) as _i6.Future<_i2.UserCredential>);

  @override
  _i6.Future<_i2.UserCredential> reauthenticateWithProvider(
          _i9.AuthProvider? provider) =>
      (super.noSuchMethod(
        Invocation.method(
          #reauthenticateWithProvider,
          [provider],
        ),
        returnValue: _i6.Future<_i2.UserCredential>.value(_FakeUserCredential_2(
          this,
          Invocation.method(
            #reauthenticateWithProvider,
            [provider],
          ),
        )),
      ) as _i6.Future<_i2.UserCredential>);

  @override
  _i6.Future<_i2.UserCredential> reauthenticateWithPopup(
          _i9.AuthProvider? provider) =>
      (super.noSuchMethod(
        Invocation.method(
          #reauthenticateWithPopup,
          [provider],
        ),
        returnValue: _i6.Future<_i2.UserCredential>.value(_FakeUserCredential_2(
          this,
          Invocation.method(
            #reauthenticateWithPopup,
            [provider],
          ),
        )),
      ) as _i6.Future<_i2.UserCredential>);

  @override
  _i6.Future<void> reauthenticateWithRedirect(_i9.AuthProvider? provider) =>
      (super.noSuchMethod(
        Invocation.method(
          #reauthenticateWithRedirect,
          [provider],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<_i2.UserCredential> linkWithPopup(_i9.AuthProvider? provider) =>
      (super.noSuchMethod(
        Invocation.method(
          #linkWithPopup,
          [provider],
        ),
        returnValue: _i6.Future<_i2.UserCredential>.value(_FakeUserCredential_2(
          this,
          Invocation.method(
            #linkWithPopup,
            [provider],
          ),
        )),
      ) as _i6.Future<_i2.UserCredential>);

  @override
  _i6.Future<void> linkWithRedirect(_i9.AuthProvider? provider) =>
      (super.noSuchMethod(
        Invocation.method(
          #linkWithRedirect,
          [provider],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<_i2.ConfirmationResult> linkWithPhoneNumber(
    String? phoneNumber, [
    _i2.RecaptchaVerifier? verifier,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #linkWithPhoneNumber,
          [
            phoneNumber,
            verifier,
          ],
        ),
        returnValue:
            _i6.Future<_i2.ConfirmationResult>.value(_FakeConfirmationResult_8(
          this,
          Invocation.method(
            #linkWithPhoneNumber,
            [
              phoneNumber,
              verifier,
            ],
          ),
        )),
      ) as _i6.Future<_i2.ConfirmationResult>);

  @override
  _i6.Future<_i2.UserCredential> reauthenticateWithCredential(
          _i2.AuthCredential? credential) =>
      (super.noSuchMethod(
        Invocation.method(
          #reauthenticateWithCredential,
          [credential],
        ),
        returnValue: _i6.Future<_i2.UserCredential>.value(_FakeUserCredential_2(
          this,
          Invocation.method(
            #reauthenticateWithCredential,
            [credential],
          ),
        )),
      ) as _i6.Future<_i2.UserCredential>);

  @override
  _i6.Future<void> reload() => (super.noSuchMethod(
        Invocation.method(
          #reload,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> sendEmailVerification(
          [_i2.ActionCodeSettings? actionCodeSettings]) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendEmailVerification,
          [actionCodeSettings],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<_i2.User> unlink(String? providerId) => (super.noSuchMethod(
        Invocation.method(
          #unlink,
          [providerId],
        ),
        returnValue: _i6.Future<_i2.User>.value(_FakeUser_1(
          this,
          Invocation.method(
            #unlink,
            [providerId],
          ),
        )),
      ) as _i6.Future<_i2.User>);

  @override
  _i6.Future<void> updateEmail(String? newEmail) => (super.noSuchMethod(
        Invocation.method(
          #updateEmail,
          [newEmail],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> updatePassword(String? newPassword) => (super.noSuchMethod(
        Invocation.method(
          #updatePassword,
          [newPassword],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> updatePhoneNumber(
          _i2.PhoneAuthCredential? phoneCredential) =>
      (super.noSuchMethod(
        Invocation.method(
          #updatePhoneNumber,
          [phoneCredential],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> updateDisplayName(String? displayName) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateDisplayName,
          [displayName],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> updatePhotoURL(String? photoURL) => (super.noSuchMethod(
        Invocation.method(
          #updatePhotoURL,
          [photoURL],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> updateProfile({
    String? displayName,
    String? photoURL,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateProfile,
          [],
          {
            #displayName: displayName,
            #photoURL: photoURL,
          },
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> verifyBeforeUpdateEmail(
    String? newEmail, [
    _i2.ActionCodeSettings? actionCodeSettings,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #verifyBeforeUpdateEmail,
          [
            newEmail,
            actionCodeSettings,
          ],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}
