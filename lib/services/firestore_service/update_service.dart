//class CreateService extends FirestoreService implements CreateServiceInterface

import 'package:caparc/common/models/user_model.dart';
import 'package:caparc/services/firestore_service/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateService extends FirestoreService implements UpdateServiceInterface {
  @override
  Future<UserModel> updateUserProfile(UserModel data) async {
    try {
      CollectionReference userReference = this.userReference;

      final DocumentReference documentReference = userReference.doc(data.id);
      await documentReference.update(data.toJson());

      final updatedData = await documentReference.get();
      return (UserModel.fromJsonAsync(
          updatedData.data() as Map<String, dynamic>));
    } on FirebaseException catch (e) {
      print(e);
      rethrow;
    }
  }
}

abstract class UpdateServiceInterface {
  Future<UserModel> updateUserProfile(UserModel data);
}
