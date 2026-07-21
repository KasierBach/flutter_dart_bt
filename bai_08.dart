import 'dart:io';

void main() {
  stdout.write('Nhập một câu: ');
  final String sentence = stdin.readLineSync() ?? '';

  // Đưa về chữ thường để "Dart" và "dart" được xem là một từ.
  final List<String> words = sentence.toLowerCase().split(' ');
  final Map<String, int> frequency = <String, int>{};

  for (final String word in words) {
    if (word.isEmpty) {
      continue;
    }

    // Nếu từ chưa có trong Map thì dùng giá trị ban đầu là 0.
    frequency[word] = (frequency[word] ?? 0) + 1;
  }

  print('Tần suất xuất hiện của các từ:');
  frequency.forEach((String word, int count) {
    print('$word: $count');
  });
}
