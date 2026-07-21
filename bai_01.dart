import 'dart:io';

void main() {
  stdout.write('Nhập số nguyên dương n: ');
  final String? input = stdin.readLineSync();
  final int? n = int.tryParse(input ?? '');

  if (n == null || n < 1) {
    print('Dữ liệu không hợp lệ. Vui lòng nhập số nguyên dương.');
    return;
  }

  int sum = 0;

  // Duyệt các số từ 1 đến n.
  for (int number = 1; number <= n; number++) {
    // Phần dư bằng 0 nghĩa là number chia hết cho 3.
    if (number % 3 == 0) {
      sum = sum + number;
    }
  }

  print('Tổng các số chia hết cho 3 từ 1 đến $n là: $sum');
}
