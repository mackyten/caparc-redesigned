import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthService implements IFirebaseAuthService {
  User? currentUser = FirebaseAuth.instance.currentUser;
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
}
