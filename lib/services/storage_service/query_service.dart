import 'package:firebase_storage/firebase_storage.dart';

class StorageQueryService implements IStorageQueryService {
  @override
  Future<String> getDownloadURL(String filePath) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(filePath);
      String downloadURL = await ref.getDownloadURL();
      print("DOWNLOAD URL: $downloadURL");
      return downloadURL;
    } catch (e) {
      print('Error generating download URL: $e');
      return '';
    }
  }
}

abstract class IStorageQueryService {
  Future<String> getDownloadURL(String filePath);
}
