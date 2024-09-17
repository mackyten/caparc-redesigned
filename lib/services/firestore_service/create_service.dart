import 'package:caparc/common/models/project_model.dart';
import 'package:caparc/services/firestore_service/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCreateService extends FirestoreService implements FirestoreCreateServiceInterface {
  //CollectionReference collection = collectionReference;

  @override
  Future<ProjectModel> create(ProjectModel project) async {
    try {
      final docRef = projectReference.doc();
      project.id = docRef.id;
      await docRef.set(project.toJson());

      return project;
    } on FirebaseException catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<bool> toggleLike(String projectId, String userId) async {
    assert(projectId.isNotEmpty, "TOGGLE LIKE ERROR: project id is empty");
    CollectionReference projects = projectReference;
    try {
      // Get the document by ID
      DocumentSnapshot documentSnapshot = await projects.doc(projectId).get();

      if (documentSnapshot.exists) {
        List<dynamic> currentList = (documentSnapshot.get('favoriteBy') ?? []);

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

abstract class FirestoreCreateServiceInterface {
  Future<ProjectModel> create(ProjectModel project);
  Future<bool> toggleLike(String projectId, String userId);
}
