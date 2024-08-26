import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService implements FirestoreServiceInterface {
  final CollectionReference<Map<String, dynamic>> _collectionReference =
      FirebaseFirestore.instance.collection('capstone-projects');

  @override
  CollectionReference<Map<String, dynamic>> get collectionReference =>
      _collectionReference;


}

abstract class FirestoreServiceInterface {
  CollectionReference<Map<String, dynamic>> get collectionReference;
  // Future<ProjectModel> create(ProjectModel project);
  // Future<bool> toggleLike(String projectId, String userId);
}
