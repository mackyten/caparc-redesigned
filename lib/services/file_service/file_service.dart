import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  Future<String> uploadFile(String fileName, String filePath) async {
    print("UPLOADING THE FILE....");
    final storageRef =
        FirebaseStorage.instance.ref().child('capstone-files/$fileName');
    final uploadTask = storageRef.putFile(File(filePath));
    final snapShot = await uploadTask
        .whenComplete(() => print("FILE UPLOADED"))
        .catchError((e) {
      print("CATCHED ERROR: ${e}");
    });

    print("FILE: LOCATION: ${storageRef.fullPath}");
    return storageRef.fullPath;
  }

  Future<void> downloadFile(String location, String filename) async {
    try {
      final directory = await getApplicationCacheDirectory();
      final filePath = "${directory.path}/$filename.pdf";

      // final bool isExisting = await isFileExisting(filePath);
      // if (isExisting) return;

      final Dio dio = Dio();

      final String url = await getDownloadURL(location);

      await dio.download(
        url,
        filePath,
        options: Options(
          headers: {HttpHeaders.acceptEncodingHeader: '*'}, // Disable gzip
        ),
        onReceiveProgress: (received, total) {
          if (total <= 0) return;
          print('percentage: ${(received / total * 100).toStringAsFixed(0)}%');
        },
      );
    } on DioException catch (e) {
      print("ERROR downloading: $filename");
      print(e);
    }
  }

  Future<bool> isFileExisting(String filePath) async {
    final file = File(filePath);
    return await file.exists();
  }

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
