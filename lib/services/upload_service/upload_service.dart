import 'package:caparc/data/models/project_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadService {
  //  await FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(user.user!.uid)
  //     .set(newUser.toJson());

  static Future<ProjectModel> create(ProjectModel project) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('capstone-projects').doc();
      project.id = docRef.id;
      await docRef.set(project.toJson());

      return project;
    } on FirebaseException catch (e) {
      print(e);
      rethrow;
    }
  }
}
