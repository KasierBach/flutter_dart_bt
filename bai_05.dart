import 'dart:io';

int findSecondLargest(List<int> numbers) {
  int? largest;
  int? secondLargest;

  for (final int number in numbers) {
    if (largest == null || number > largest) {
      // Giá trị lớn nhất cũ trở thành giá trị lớn thứ hai.
      secondLargest = largest;
      largest = number;
    } else if (number < largest &&
        (secondLargest == null || number > secondLargest)) {
      // Dùng < largest để bỏ qua giá trị lớn nhất bị lặp lại.
      secondLargest = number;
    }
  }

  if (secondLargest == null) {
    throw ArgumentError('Danh sách phải có ít nhất hai giá trị khác nhau.');
  }

  return secondLargest;
}

void main() {
  stdout.write('Nhập các số nguyên, cách nhau bằng dấu cách: ');
  final String input = (stdin.readLineSync() ?? '').trim();
  final List<String> parts = input.isEmpty
      ? <String>[]
      : input.split(RegExp(r'\s+'));
  final List<int> numbers = <int>[];

  for (final String part in parts) {
    final int? number = int.tryParse(part);

    if (number == null) {
      print('"$part" không phải là số nguyên.');
      return;
    }

    numbers.add(number);
  }

  try {
    final int result = findSecondLargest(numbers);
    print('Số lớn thứ hai là: $result');
  } on ArgumentError catch (error) {
    print(error.message);
  }
}
