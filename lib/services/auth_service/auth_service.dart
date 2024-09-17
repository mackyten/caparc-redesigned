import 'package:caparc/blocs/user_bloc/bloc.dart';
import 'package:caparc/blocs/user_bloc/events.dart';
import 'package:caparc/blocs/user_bloc/state.dart';
import 'package:caparc/common/models/user_model.dart';
import 'package:caparc/services/firestore_service/query_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService implements IFirebaseAuthService {
  User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> signIn(BuildContext context, UserBloc userBloc) async {
    try {
      //TODO update to dynamic
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: "qletzsteven11@gmail.com",
        password: "123456",
      );
      FirestoreQueryInterface queryInterface = FirestoreQuery();
      UserModel? user = await queryInterface.getUser(userCredential.user!.uid);
      if (user == null) {
        signOut();
      }

      userBloc.add(
        SetUser(
          userState: UserState(
            id: user!.id,
            firstname: user.firstname,
            middlename: user.middlename,
            lastname: user.lastname,
            birthdate: user.birthdate,
            idNumber: user.idNumber,
            accountStatus: user.accountStatus,
            prefix: user.prefix,
            suffix: user.suffix,
            email: user.email,
            course: user.course,
            avatarLink: user.avatarLink,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
      } else {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  @override
  Future<void> signOut() async {
    try {
      auth.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
      } else {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  @override
  Future<dynamic> register({required UserModel newUser}) async {
    try {
      final UserCredential user = await auth.createUserWithEmailAndPassword(
          email: newUser.email, password: newUser.password);

      newUser.id = user.user!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.user!.uid)
          .set(newUser.toJson());

      return newUser;
    } on FirebaseAuthException catch (e) {
      return e;
    } on FirebaseException catch (e) {
      return e;
    }
  }

  @override
  Future<void> changeEmail(
      {required String newEmail, required VoidCallback onReauthNeeded}) async {
    if (currentUser != null) {
      try {
        await currentUser?.verifyBeforeUpdateEmail(newEmail);
        await FirebaseAuth.instance.currentUser?.reload();
        currentUser = FirebaseAuth.instance.currentUser;
      } on FirebaseAuthException catch (e) {
        if (kDebugMode) {
          print("ERROR: ${e.code}");
        }
        if (e.code == "requires-recent-login") {
          onReauthNeeded();
        }
      }
    }
  }

  @override
  Future<void> reauthenticate(
      {required String password, VoidCallback? onSuccess}) async {
    if (currentUser != null) {
      try {
        AuthCredential credential = EmailAuthProvider.credential(
            email: currentUser!.email!, password: password);
        await currentUser!.reauthenticateWithCredential(credential);
        if (onSuccess != null) {
          onSuccess();
        }
      } on FirebaseAuthException catch (e) {
        if (kDebugMode) {
          print("AUTH:$e");
        }
      } catch (e) {
        if (kDebugMode) {
          print("OTHER:$e");
        }
      }
    }
  }

  @override
  Future<void> reathenticateThenChangeEmail({
    required String password,
    required String newEmail,
    required VoidCallback onError,
    required Function(User user) onSuccess,
  }) async {
    await reauthenticate(password: password).then((value) {
      return changeEmail(
        newEmail: newEmail,
        onReauthNeeded: onError,
      ).then((value) => onSuccess(
            currentUser!,
          ));
    });
  }

  @override
  Future<void> changePassword({required String newPassword}) async {
    try {
      currentUser?.reload();
      await currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw e.message ?? "Unknown error occured";
    }
  }
}

abstract class IFirebaseAuthService {
  Future<void> changeEmail(
      {required String newEmail, required VoidCallback onReauthNeeded});
  Future<void> reauthenticate({
    required String password,
    required VoidCallback onSuccess,
  });
  Future<void> reathenticateThenChangeEmail({
    required String password,
    required String newEmail,
    required VoidCallback onError,
    required Function(User user) onSuccess,
  });
  Future<void> changePassword({required String newPassword});
  Future<void> signIn(BuildContext context, UserBloc userBloc);
  Future<void> signOut();
  Future<dynamic> register({required UserModel newUser});
}
