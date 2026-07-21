Stream<int> createCountdownStream(int start) async* {
  final Stream<int> numbers = Stream<int>.periodic(
    const Duration(seconds: 1),
    (int index) => start - index,
  );

  // takeWhile tự dừng lắng nghe khi giá trị nhỏ hơn 0.
  await for (final int number in numbers.takeWhile((int value) => value >= 0)) {
    yield number;
  }
}

Future<void> main() async {
  print('Bắt đầu đếm ngược:');

  await for (final int number in createCountdownStream(10)) {
    print(number);
  }

  print('Kết thúc!');
}
