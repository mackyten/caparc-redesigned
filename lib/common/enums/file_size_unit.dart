enum FileSizeUnit {
  kb,
  mb,
  gb,
}

class FileSizeUnitHelper {
  static String getStringValue(FileSizeUnit unit) {
    switch (unit) {
      case FileSizeUnit.kb:
        return "Kilobytes";
      case FileSizeUnit.mb:
        return "Megabytes";
      case FileSizeUnit.gb:
        return "Gigabytes";
      default:
        return "unknown unit";
    }
  }

  static String getStringValueAbrev(FileSizeUnit unit) {
    switch (unit) {
      case FileSizeUnit.kb:
        return "Kb";
      case FileSizeUnit.mb:
        return "Mb";
      case FileSizeUnit.gb:
        return "Gb";
      default:
        return "unknown unit";
    }
  }
}
