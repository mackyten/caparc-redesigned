import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService implements FirestoreServiceInterface {
  final CollectionReference<Map<String, dynamic>> _projectReference =
      FirebaseFirestore.instance.collection('capstone-projects');

  final CollectionReference<Map<String, dynamic>> _courseReference =
      FirebaseFirestore.instance.collection('courses');

  final CollectionReference<Map<String, dynamic>> _userReference =
      FirebaseFirestore.instance.collection('users');

  @override
  CollectionReference<Map<String, dynamic>> get projectReference =>
      _projectReference;

  @override
  CollectionReference<Map<String, dynamic>> get courseReference =>
      _courseReference;

  @override
  CollectionReference<Map<String, dynamic>> get userReference => _userReference;
}

abstract class FirestoreServiceInterface {
  CollectionReference<Map<String, dynamic>> get projectReference;
  CollectionReference<Map<String, dynamic>> get courseReference;
  CollectionReference<Map<String, dynamic>> get userReference;
  // Future<ProjectModel> create(ProjectModel project);
  // Future<bool> toggleLike(String projectId, String userId);
}
