import 'dart:io';

void main() {
  final List<String> todos = <String>[];
  bool isRunning = true;

  while (isRunning) {
    print('\n===== TODO LIST =====');
    print('1. Thêm công việc');
    print('2. Xóa công việc theo tên');
    print('3. Hiển thị công việc');
    print('4. Thoát');
    stdout.write('Chọn chức năng: ');

    final String choice = stdin.readLineSync() ?? '';

    switch (choice) {
      case '1':
        stdout.write('Nhập tên công việc mới: ');
        final String todo = (stdin.readLineSync() ?? '').trim();

        if (todo.isEmpty) {
          print('Tên công việc không được để trống.');
        } else {
          todos.add(todo);
          print('Đã thêm công việc.');
        }
      case '2':
        stdout.write('Nhập chính xác tên công việc cần xóa: ');
        final String todo = (stdin.readLineSync() ?? '').trim();
        final bool wasRemoved = todos.remove(todo);

        if (wasRemoved) {
          print('Đã xóa công việc.');
        } else {
          print('Không tìm thấy công việc này.');
        }
      case '3':
        if (todos.isEmpty) {
          print('Danh sách đang trống.');
        } else {
          print('\nCác công việc cần làm:');
          for (int i = 0; i < todos.length; i++) {
            print('${i + 1}. ${todos[i]}');
          }
        }
      case '4':
        isRunning = false;
        print('Đã thoát chương trình.');
      default:
        print('Lựa chọn không hợp lệ.');
    }
  }
}
