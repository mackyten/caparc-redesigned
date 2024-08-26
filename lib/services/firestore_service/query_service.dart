import 'package:caparc/data/models/project_model.dart';
import 'package:caparc/services/firestore_service/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///TODO ADD HOME QUERIES FOR PROJECTS
class FirestoreQuery extends FirestoreService
    implements FirestoreQueryInterface {
  @override
  Future<List<ProjectModel>> getDocumentsByTitle(String title) async {
    try {
      // Reference to the collection
      CollectionReference collection = collectionReference;

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
}

abstract class FirestoreQueryInterface {
  Future<List<ProjectModel>> getDocumentsByTitle(String title);
}
