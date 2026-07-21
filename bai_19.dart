import 'dart:io';

class Book {
  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.publishedYear,
  });

  final String id;
  final String title;
  final String author;
  final int publishedYear;

  // Chuyển một quyển sách thành một dòng để ghi vào file.
  String toFileLine() {
    return '$id|$title|$author|$publishedYear';
  }

  // Tạo đối tượng Book từ một dòng đọc được trong file.
  factory Book.fromFileLine(String line) {
    final List<String> parts = line.split('|');

    if (parts.length != 4) {
      throw const FormatException('Dòng dữ liệu sách không đúng định dạng.');
    }

    return Book(
      id: parts[0],
      title: parts[1],
      author: parts[2],
      publishedYear: int.parse(parts[3]),
    );
  }

  void display() {
    print('$id | $title | $author | $publishedYear');
  }
}

class Library {
  Library(this.fileName);

  final String fileName;
  final List<Book> books = <Book>[];

  void loadFromFile() {
    final File file = File(fileName);

    try {
      if (!file.existsSync()) {
        print('Chưa có file $fileName. Danh sách ban đầu đang trống.');
        return;
      }

      final List<String> lines = file.readAsLinesSync();

      for (int i = 0; i < lines.length; i++) {
        if (lines[i].trim().isEmpty) {
          continue;
        }

        try {
          books.add(Book.fromFileLine(lines[i]));
        } on FormatException catch (error) {
          print('Bỏ qua dòng ${i + 1}: ${error.message}');
        }
      }

      print('Đã đọc ${books.length} quyển sách từ file.');
    } on FileSystemException catch (error) {
      print('Không thể đọc file: ${error.message}');
    }
  }

  bool addBook(Book book) {
    for (final Book currentBook in books) {
      if (currentBook.id == book.id) {
        return false;
      }
    }

    books.add(book);
    return true;
  }

  void displayAllBooks() {
    if (books.isEmpty) {
      print('Thư viện chưa có sách.');
      return;
    }

    print('\nMã | Tên sách | Tác giả | Năm xuất bản');
    for (final Book book in books) {
      book.display();
    }
  }

  void searchBooks(String keyword) {
    final String normalizedKeyword = keyword.toLowerCase();
    final List<Book> results = <Book>[];

    for (final Book book in books) {
      final bool titleMatches = book.title.toLowerCase().contains(
        normalizedKeyword,
      );
      final bool authorMatches = book.author.toLowerCase().contains(
        normalizedKeyword,
      );

      if (titleMatches || authorMatches) {
        results.add(book);
      }
    }

    if (results.isEmpty) {
      print('Không tìm thấy sách phù hợp.');
      return;
    }

    print('Kết quả tìm kiếm:');
    for (final Book book in results) {
      book.display();
    }
  }

  bool removeBook(String id) {
    final int oldLength = books.length;
    books.removeWhere((Book book) => book.id == id);
    return books.length < oldLength;
  }

  void saveToFile() {
    final File file = File(fileName);

    try {
      final List<String> lines = <String>[];

      for (final Book book in books) {
        lines.add(book.toFileLine());
      }

      file.writeAsStringSync(lines.join('\n'));
      print('Đã lưu ${books.length} quyển sách vào $fileName.');
    } on FileSystemException catch (error) {
      print('Không thể ghi file: ${error.message}');
    }
  }
}

String readRequiredText(String message) {
  while (true) {
    stdout.write(message);
    final String value = (stdin.readLineSync() ?? '').trim();

    if (value.isEmpty) {
      print('Thông tin này không được để trống.');
    } else if (value.contains('|')) {
      print('Thông tin không được chứa ký tự |.');
    } else {
      return value;
    }
  }
}

int readPublishedYear() {
  while (true) {
    stdout.write('Nhập năm xuất bản: ');
    final int? year = int.tryParse(stdin.readLineSync() ?? '');

    if (year != null && year > 0) {
      return year;
    }

    print('Năm xuất bản phải là số nguyên dương.');
  }
}

void main() {
  final Library library = Library('books.txt');
  library.loadFromFile();

  while (true) {
    print('\n===== QUẢN LÝ THƯ VIỆN =====');
    print('1. Thêm sách');
    print('2. Hiển thị tất cả sách');
    print('3. Tìm sách theo tên hoặc tác giả');
    print('4. Xóa sách theo mã');
    print('5. Lưu danh sách vào file');
    print('0. Thoát');
    stdout.write('Chọn chức năng: ');

    final String choice = stdin.readLineSync() ?? '';

    switch (choice) {
      case '1':
        final String id = readRequiredText('Nhập mã sách: ');
        final String title = readRequiredText('Nhập tên sách: ');
        final String author = readRequiredText('Nhập tác giả: ');
        final int year = readPublishedYear();
        final Book book = Book(
          id: id,
          title: title,
          author: author,
          publishedYear: year,
        );

        if (library.addBook(book)) {
          print('Đã thêm sách.');
        } else {
          print('Mã sách đã tồn tại.');
        }
      case '2':
        library.displayAllBooks();
      case '3':
        final String keyword = readRequiredText('Nhập từ khóa tìm kiếm: ');
        library.searchBooks(keyword);
      case '4':
        final String id = readRequiredText('Nhập mã sách cần xóa: ');

        if (library.removeBook(id)) {
          print('Đã xóa sách.');
        } else {
          print('Không tìm thấy mã sách.');
        }
      case '5':
        library.saveToFile();
      case '0':
        // Tự lưu một lần nữa để tránh mất thay đổi khi người dùng thoát.
        library.saveToFile();
        print('Đã thoát chương trình.');
        return;
      default:
        print('Lựa chọn không hợp lệ.');
    }
  }
}
