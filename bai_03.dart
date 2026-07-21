void main() {
  print('BẢNG CỬU CHƯƠNG TỪ 2 ĐẾN 9\n');

  // Vòng lặp ngoài tạo từng dòng từ phép nhân 1 đến 10.
  for (int multiplier = 1; multiplier <= 10; multiplier++) {
    String row = '';

    // Vòng lặp trong tạo các cột từ bảng 2 đến bảng 9.
    for (int table = 2; table <= 9; table++) {
      final String calculation = '$table x $multiplier = ${table * multiplier}';
      row = row + calculation.padRight(14);
    }

    print(row);
  }
}
