List<T> sortList<T, K extends Comparable<K>>(
  List<T> list,
  K Function(T) keySelector, {
  bool ascending = false,
}) {
  list.sort((a, b) {
    final aKey = keySelector(a);
    final bKey = keySelector(b);
    return ascending ? aKey.compareTo(bKey) : bKey.compareTo(aKey);
  });
  return list;
}
