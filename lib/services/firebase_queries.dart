import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseQueries {
  static Future<bool> checkTitleIfExists(String title) async {
    try {
      final CollectionReference projectsRef =
          FirebaseFirestore.instance.collection("capstone-projects");

      final QuerySnapshot querySnapshot =
          await projectsRef.where("title", isEqualTo: title).get();

      return querySnapshot.docs.isNotEmpty;
    } on FirebaseException catch (e) {
      print("Firebase_Exception: ${e.message}");
      return false;
    }
  }
}
