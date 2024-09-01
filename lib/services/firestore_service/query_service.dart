import 'package:caparc/common/models/course_model.dart';
import 'package:caparc/data/models/project_model.dart';
import 'package:caparc/data/models/user_model.dart';
import 'package:caparc/services/firestore_service/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///TODO ADD HOME QUERIES FOR PROJECTS
class FirestoreQuery extends FirestoreService
    implements FirestoreQueryInterface {
  @override
  Future<List<ProjectModel>> getDocumentsByTitle(String title) async {
    try {
      // Reference to the collection
      CollectionReference collection = projectReference;

      // Query the documents where the 'title' field matches the given title
      QuerySnapshot querySnapshot =
          await collection.where('title', isEqualTo: title).get();

      // Extract the data from the documents
      List<Map<String, dynamic>> documents = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return documents.map((e) => ProjectModel.fromJson(e)).toList();
    } catch (e) {
      print('Error fetching documents: $e');
      return [];
    }
  }

  @override
  Future<List<CourseModel>> getCourses() async {
    try {
      // Reference to the collection
      CollectionReference collection = courseReference;

      // Query the documents where the 'title' field matches the given title
      QuerySnapshot querySnapshot = await collection.get();

      // Extract the data from the documents
      List<Map<String, dynamic>> documents = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return documents.map((e) => CourseModel.fromJson(e)).toList();
    } catch (e) {
      print('Error fetching documents: $e');
      return [];
    }
  }

  @override
  Future<CourseModel?> getCourseById(String courseId) async {
    try {
      // Reference to the collection
      CollectionReference collectionRef = courseReference;

      final DocumentSnapshot doc = await collectionRef.doc(courseId).get();

      return CourseModel.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      print('Error fetching documents: $e');
      return null;
    }
  }

  @override
  Future<UserModel?> getUser(String userId) async {
    final DocumentSnapshot userSnapshot = await userReference.doc(userId).get();

    return UserModel.fromJsonAsync(userSnapshot.data() as Map<String, dynamic>);
  }
}

abstract class FirestoreQueryInterface {
  Future<List<ProjectModel>> getDocumentsByTitle(String title);
  Future<List<CourseModel>> getCourses();
  Future<CourseModel?> getCourseById(String courseId);
  Future<UserModel?> getUser(String userId);
}
