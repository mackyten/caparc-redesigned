import 'package:caparc/blocs/user_bloc/bloc.dart';
import 'package:caparc/blocs/user_bloc/events.dart';
import 'package:caparc/blocs/user_bloc/state.dart';
import 'package:caparc/data/models/user_model.dart';
import 'package:caparc/services/firestore_service/query_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Auth {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static signIn(BuildContext context, UserBloc userBloc) async {
    try {
      //markangelosabado10@gmail.com
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

      // final DocumentReference document = FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userCredential.user?.uid);

      // await document.get().then((snapshot) async {
      //   print(snapshot);
      //   if (snapshot.exists) {

      //   } else {
      //     signOut();
      //   }
      // }).onError((error, stackTrace) {});
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

  static register({required UserModel newUser}) async {
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

  static signOut() async {
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
}
