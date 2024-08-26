import 'package:caparc/common/enums/file_size_unit.dart';

class FileSize {
  static double convertBytes(int bytes, FileSizeUnit unit) {
    switch (unit) {
      case FileSizeUnit.kb:
        return bytes / 1000;
      case FileSizeUnit.mb:
        return bytes / (1000 * 1000);
      case FileSizeUnit.gb:
        return bytes / (1000 * 1000 * 1000);
      default:
        throw ArgumentError('Invalid unit. Use KB, MB, or GB.');
    }
  }

  static String formatBytes(int bytes) {
    if (bytes < 1000) {
      return '$bytes Bytes';
    } else if (bytes < 1000 * 1000) {
      return '${(bytes / 1000).toStringAsFixed(2)} KB';
    } else if (bytes < 1000 * 1000 * 1000) {
      return '${(bytes / (1000 * 1000)).toStringAsFixed(2)} MB';
    } else {
      return '${(bytes / (1000 * 1000 * 1000)).toStringAsFixed(2)} GB';
    }
  }
}
