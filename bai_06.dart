import 'dart:io';

int fibonacciNormal(int n) {
  if (n <= 1) {
    return n;
  }

  return fibonacciNormal(n - 1) + fibonacciNormal(n - 2);
}

int fibonacciMemo(int n, Map<int, int> cache) {
  // Nếu đã tính trước đó thì lấy ngay từ Map.
  if (cache.containsKey(n)) {
    return cache[n]!;
  }

  final int result = fibonacciMemo(n - 1, cache) + fibonacciMemo(n - 2, cache);
  cache[n] = result;
  return result;
}

void main() {
  stdout.write('Nhập n từ 0 đến 40: ');
  final int? n = int.tryParse(stdin.readLineSync() ?? '');

  // Giới hạn 40 để cách đệ quy thông thường không chạy quá lâu.
  if (n == null || n < 0 || n > 40) {
    print('Vui lòng nhập số nguyên từ 0 đến 40.');
    return;
  }

  final Stopwatch normalWatch = Stopwatch()..start();
  final int normalResult = fibonacciNormal(n);
  normalWatch.stop();

  final Map<int, int> cache = <int, int>{0: 0, 1: 1};
  final Stopwatch memoWatch = Stopwatch()..start();
  final int memoResult = fibonacciMemo(n, cache);
  memoWatch.stop();

  print('\nFibonacci($n) = $normalResult');
  print('Đệ quy thường: ${normalWatch.elapsedMicroseconds} micro giây');
  print('Memoization: ${memoWatch.elapsedMicroseconds} micro giây');
  print('Hai kết quả có giống nhau: ${normalResult == memoResult}');
}
