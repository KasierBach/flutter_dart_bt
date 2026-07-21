import 'dart:io';

bool isPalindrome(String str) {
  // Chỉ cần kiểm tra đến giữa chuỗi.
  for (int i = 0; i < str.length ~/ 2; i++) {
    final int oppositeIndex = str.length - 1 - i;

    if (str[i] != str[oppositeIndex]) {
      return false;
    }
  }

  return true;
}

void main() {
  stdout.write('Nhập chuỗi cần kiểm tra: ');
  final String text = stdin.readLineSync() ?? '';

  if (isPalindrome(text)) {
    print('"$text" là chuỗi đối xứng.');
  } else {
    print('"$text" không phải là chuỗi đối xứng.');
  }
}
