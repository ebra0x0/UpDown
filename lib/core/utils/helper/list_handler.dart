abstract class HasTimestamps {
  DateTime? get createdAt;
  DateTime? get updatedAt;
}

abstract class ListHandler {
  static List<T> orderByDate<T extends HasTimestamps>(List<T> list) {
    list.sort((a, b) {
      final aUpdated = a.updatedAt;
      final bUpdated = b.updatedAt;

      if (aUpdated != null && bUpdated != null) {
        return bUpdated.compareTo(aUpdated); // الأحدث أولًا
      }

      if (aUpdated != null) return -1; // a عنده updatedAt، نخليه قبل
      if (bUpdated != null) return 1; // b عنده updatedAt، نخليه قبل

      // الاتنين ماعندهمش updatedAt → نرتب حسب createdAt
      final aCreated = a.createdAt;
      final bCreated = b.createdAt;

      if (aCreated != null && bCreated != null) {
        return bCreated.compareTo(aCreated); // الأحدث أولًا
      }

      if (aCreated != null) return -1;
      if (bCreated != null) return 1;

      return 0;
    });

    return list;
  }
}
