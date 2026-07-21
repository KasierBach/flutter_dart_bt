Future<String> fetchUserName() async {
  await Future<void>.delayed(const Duration(seconds: 2));
  return 'Nguyen Van A';
}

Future<double> fetchUserBalance() async {
  await Future<void>.delayed(const Duration(seconds: 1));
  return 1500.5;
}

Future<void> getUserInfoParallel() async {
  final Stopwatch stopwatch = Stopwatch()..start();

  // Future.wait khởi chạy và chờ cả hai Future cùng lúc.
  final List<Object> results = await Future.wait<Object>(<Future<Object>>[
    fetchUserName(),
    fetchUserBalance(),
  ]);

  stopwatch.stop();
  final String name = results[0] as String;
  final double balance = results[1] as double;

  print('Tên: $name');
  print('Số dư: $balance');
  print('Thời gian gọi song song: ${stopwatch.elapsedMilliseconds} ms');
}

Future<void> getUserInfoSequential() async {
  final Stopwatch stopwatch = Stopwatch()..start();

  // Lệnh thứ hai chỉ bắt đầu sau khi lệnh thứ nhất hoàn thành.
  final String name = await fetchUserName();
  final double balance = await fetchUserBalance();

  stopwatch.stop();
  print('Tên: $name');
  print('Số dư: $balance');
  print('Thời gian gọi tuần tự: ${stopwatch.elapsedMilliseconds} ms');
}

Future<void> main() async {
  print('===== GỌI SONG SONG =====');
  await getUserInfoParallel();

  print('\n===== GỌI TUẦN TỰ =====');
  await getUserInfoSequential();
}
