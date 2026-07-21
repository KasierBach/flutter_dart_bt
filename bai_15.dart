import 'dart:io';

void main() {
  while (true) {
    stdout.write('Nhập một số nguyên: ');
    final String? input = stdin.readLineSync();

    if (input == null) {
      print('\nKhông còn dữ liệu nhập.');
      return;
    }

    try {
      // int.parse sẽ ném FormatException nếu chuỗi không phải số nguyên.
      final int number = int.parse(input);
      print('Bạn đã nhập đúng số nguyên: $number');
      break;
    } on FormatException {
      print('Dữ liệu không hợp lệ, vui lòng nhập lại.');
    }
  }
}
