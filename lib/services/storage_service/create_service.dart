import 'dart:io';

import 'package:caparc/services/storage_service/storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageCreateService extends StorageService
    implements StorageCreateServiceInterface {
  StorageCreateService({required super.fileName});

  @override
  Future<String> uploadCapstoneFile(String filePath) async {
    StorageService storageService = StorageService(fileName: fileName);
    Reference fileRef = storageService.capstoneFileReference;
    final uploadTask = fileRef.putFile(File(filePath));
    await uploadTask.whenComplete(() {
      if (kDebugMode) {
        print("FILE UPLOADED");
      }
    });

    return fileRef.fullPath;
  }

  @override
  Future<String> uploadAvatar(String filePath) async {
    StorageService storageService = StorageService(fileName: fileName);
    Reference fileRef = storageService.avatarFileReference;
    final uploadTask = fileRef.putFile(File(filePath));
    await uploadTask.whenComplete(() {
      if (kDebugMode) {
        print("AVATAR UPLOADED");
      }
    });

    return fileRef.fullPath;
  }
}

abstract class StorageCreateServiceInterface {
  Future<String> uploadCapstoneFile(String filePath);
  Future<String> uploadAvatar(String filePath);
}
