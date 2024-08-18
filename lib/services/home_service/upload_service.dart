import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  static Future<bool> toggleLike(String projectId, String userId) async {
    assert(projectId.isNotEmpty, "TOGGLE LIKE ERROR: project id is empty");
    CollectionReference projects =
        FirebaseFirestore.instance.collection('capstone-projects');

    try {
      // Get the document by ID
      DocumentSnapshot documentSnapshot = await projects.doc(projectId).get();

      if (documentSnapshot.exists) {
        List<dynamic> currentList =
            (documentSnapshot.get('favoriteBy') ?? []);

        if (currentList.contains(userId)) {
          // Remove the value if it already exists in the list
          await projects.doc(projectId).update({
            'favoriteBy': FieldValue.arrayRemove([userId])
          });
          print('UserId removed from the list');
          return false;
        } else {
          // Add the value if it doesn't exist in the list
          await projects.doc(projectId).update({
            'favoriteBy': FieldValue.arrayUnion([userId])
          });
          print('UserId added to the list');
          return true;
        }
      } else {
        print('Document does not exist');
        return false;
      }
    } catch (e) {
      print('Error updating document: $e');
      return false;
    }
  }
}
