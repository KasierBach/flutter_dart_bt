import 'dart:async';
import 'dart:io';

// Đổi thành true để thử trường hợp API gặp lỗi.
const bool simulateApiError = false;
const double defaultExchangeRate = 23000;

Future<double> fetchExchangeRate() async {
  await Future<void>.delayed(const Duration(seconds: 1));

  if (simulateApiError) {
    throw Exception('API tỷ giá không phản hồi.');
  }

  return 25500;
}

Future<double> getExchangeRate() async {
  try {
    final double rate = await fetchExchangeRate();
    print('Lấy tỷ giá từ API thành công.');
    return rate;
  } catch (error) {
    print('Có lỗi xảy ra: $error');
    print('Sử dụng tỷ giá dự phòng: $defaultExchangeRate VND/USD.');
    return defaultExchangeRate;
  }
}

Future<void> main() async {
  while (true) {
    stdout.write('\nNhập số tiền USD hoặc nhập "exit" để thoát: ');
    final String input = (stdin.readLineSync() ?? '').trim();

    if (input.toLowerCase() == 'exit') {
      print('Đã thoát chương trình.');
      return;
    }

    final double? usd = double.tryParse(input);

    if (usd == null || usd < 0) {
      print('Vui lòng nhập một số tiền không âm.');
      continue;
    }

    final double exchangeRate = await getExchangeRate();
    final double vnd = usd * exchangeRate;

    print('${usd.toStringAsFixed(2)} USD = ${vnd.toStringAsFixed(0)} VND');
  }
}
