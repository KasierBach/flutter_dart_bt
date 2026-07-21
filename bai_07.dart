void main() {
  final List<int> list1 = <int>[1, 2, 3, 4, 5];
  final List<int> list2 = <int>[3, 4, 5, 6, 7];

  // Set chỉ giữ một lần cho mỗi giá trị.
  final Set<int> set1 = list1.toSet();
  final Set<int> set2 = list2.toSet();

  final List<int> union = set1.union(set2).toList();
  final List<int> intersection = set1.intersection(set2).toList();

  print('Danh sách 1: $list1');
  print('Danh sách 2: $list2');
  print('Hợp của hai danh sách: $union');
  print('Giao của hai danh sách: $intersection');
}
