part of 'exercise_pages.dart';

abstract class _Vehicle {
  String move();
}

class _Car extends _Vehicle {
  @override
  String move() => 'Car: Di chuyển bằng bánh xe.';
}

class _Bike extends _Vehicle {
  @override
  String move() => 'Bike: Di chuyển bằng sức người.';
}

class _Airplane extends _Vehicle {
  @override
  String move() => 'Airplane: Bay trên không.';
}

class Exercise11Page extends StatelessWidget {
  const Exercise11Page({super.key});

  String runVehicles() {
    final List<_Vehicle> vehicles = <_Vehicle>[_Car(), _Bike(), _Airplane()];
    return vehicles.map((_Vehicle vehicle) => vehicle.move()).join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return _StaticRunner(
      buttonLabel: 'Gọi move() cho tất cả',
      description: 'Danh sách có cùng kiểu Vehicle nhưng chứa ba lớp con.',
      calculate: runVehicles,
    );
  }
}

mixin _Logger {
  String log(String message) {
    return '[${DateTime.now().toIso8601String()}] $message';
  }
}

mixin _Validator {
  bool isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }
}

class _UserService with _Logger, _Validator {
  String validateAndLog(String email) {
    final bool valid = isValidEmail(email);
    return '${log(valid ? 'Email hợp lệ' : 'Email không hợp lệ')}\n'
        'isValidEmail("$email") = $valid';
  }
}

class Exercise12Page extends StatelessWidget {
  const Exercise12Page({super.key});

  @override
  Widget build(BuildContext context) {
    final _UserService service = _UserService();
    return _SingleInputRunner(
      label: 'Email cần kiểm tra',
      hint: 'Ví dụ: student@example.com',
      initialValue: 'student@example.com',
      calculate: service.validateAndLog,
      actionLabel: 'Validate và ghi log',
    );
  }
}

class _DatabaseConnection {
  _DatabaseConnection._();

  static final _DatabaseConnection _instance = _DatabaseConnection._();

  static _DatabaseConnection getInstance() => _instance;

  String connect() => 'Connected to database';

  String disconnect() => 'Disconnected';
}

class Exercise13Page extends StatelessWidget {
  const Exercise13Page({super.key});

  String runSingleton() {
    final _DatabaseConnection first = _DatabaseConnection.getInstance();
    final _DatabaseConnection second = _DatabaseConnection.getInstance();
    return '${first.connect()}\n'
        'identical(first, second) = ${identical(first, second)}\n'
        '${second.disconnect()}';
  }

  @override
  Widget build(BuildContext context) {
    return _StaticRunner(
      buttonLabel: 'Tạo hai tham chiếu',
      description: 'getInstance() luôn trả về cùng một đối tượng.',
      calculate: runSingleton,
    );
  }
}

enum _UiStatus { pending, approved, rejected, done }

extension _UiStatusExtension on _UiStatus {
  String getDisplayName() {
    switch (this) {
      case _UiStatus.pending:
        return 'Đang chờ';
      case _UiStatus.approved:
        return 'Đã duyệt';
      case _UiStatus.rejected:
        return 'Đã từ chối';
      case _UiStatus.done:
        return 'Hoàn thành';
    }
  }

  bool isCompleted() => this == _UiStatus.done;
}

class Exercise14Page extends StatefulWidget {
  const Exercise14Page({super.key});

  @override
  State<Exercise14Page> createState() => _Exercise14PageState();
}

class _Exercise14PageState extends State<Exercise14Page> {
  _UiStatus selected = _UiStatus.pending;

  @override
  Widget build(BuildContext context) {
    return _LabPage(
      children: <Widget>[
        _LabSection(
          title: 'Chọn một Status',
          child: DropdownButtonFormField<_UiStatus>(
            initialValue: selected,
            items: _UiStatus.values
                .map(
                  (_UiStatus status) => DropdownMenuItem<_UiStatus>(
                    value: status,
                    child: Text(status.name),
                  ),
                )
                .toList(),
            onChanged: (_UiStatus? value) {
              if (value != null) {
                setState(() => selected = value);
              }
            },
            decoration: _compactInput('Status'),
          ),
        ),
        _LabSection(
          title: 'Extension trả về',
          child: _ResultPanel(
            value:
                'getDisplayName(): ${selected.getDisplayName()}\n'
                'isCompleted(): ${selected.isCompleted()}',
          ),
        ),
      ],
    );
  }
}

class Exercise15Page extends StatelessWidget {
  const Exercise15Page({super.key});

  String parseInteger(String input) {
    try {
      final int number = int.parse(input.trim());
      return 'Nhập thành công.\nGiá trị số nguyên: $number';
    } on FormatException {
      throw const FormatException(
        'FormatException: dữ liệu không phải số nguyên.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _SingleInputRunner(
      label: 'Thử nhập số hoặc chuỗi',
      hint: 'Ví dụ đúng: 42, ví dụ sai: abc',
      initialValue: 'abc',
      calculate: parseInteger,
      actionLabel: 'Thử int.parse',
    );
  }
}

Future<String> _fetchUserName() async {
  await Future<void>.delayed(const Duration(seconds: 2));
  return 'Nguyen Van A';
}

Future<double> _fetchUserBalance() async {
  await Future<void>.delayed(const Duration(seconds: 1));
  return 1500.5;
}

class Exercise16Page extends StatefulWidget {
  const Exercise16Page({super.key});

  @override
  State<Exercise16Page> createState() => _Exercise16PageState();
}

class _Exercise16PageState extends State<Exercise16Page> {
  bool running = false;
  String? result;

  Future<void> compareCalls() async {
    setState(() {
      running = true;
      result = null;
    });

    final Stopwatch parallelWatch = Stopwatch()..start();
    final List<Object> parallel = await Future.wait<Object>(<Future<Object>>[
      _fetchUserName(),
      _fetchUserBalance(),
    ]);
    parallelWatch.stop();

    final Stopwatch sequentialWatch = Stopwatch()..start();
    final String name = await _fetchUserName();
    final double balance = await _fetchUserBalance();
    sequentialWatch.stop();

    if (!mounted) {
      return;
    }
    setState(() {
      running = false;
      result =
          'Future.wait\n'
          'Tên: ${parallel[0]}\n'
          'Số dư: ${parallel[1]}\n'
          'Thời gian: ${parallelWatch.elapsedMilliseconds} ms\n\n'
          'Tuần tự\n'
          'Tên: $name\n'
          'Số dư: $balance\n'
          'Thời gian: ${sequentialWatch.elapsedMilliseconds} ms';
    });
  }

  @override
  Widget build(BuildContext context) {
    return _LabPage(
      children: <Widget>[
        _LabSection(
          title: 'So sánh cách gọi',
          description:
              'Future.wait mất khoảng 2 giây; gọi tuần tự mất khoảng 3 giây.',
          child: Align(
            alignment: Alignment.centerLeft,
            child: FilledButton.icon(
              onPressed: running ? null : compareCalls,
              icon: running
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.play_arrow_rounded),
              label: Text(running ? 'Đang chờ Future' : 'Chạy so sánh'),
            ),
          ),
        ),
        _LabSection(
          title: 'Kết quả',
          child: _ResultPanel(
            value: result,
            emptyMessage: running
                ? 'Hai lượt kiểm tra đang chạy.'
                : 'Nhấn Chạy so sánh để bắt đầu.',
          ),
        ),
      ],
    );
  }
}

Stream<int> _createCountdownStream(int start) async* {
  final Stream<int> values = Stream<int>.periodic(
    const Duration(seconds: 1),
    (int index) => start - index,
  );
  await for (final int value in values.takeWhile((int value) => value >= 0)) {
    yield value;
  }
}

class Exercise17Page extends StatefulWidget {
  const Exercise17Page({super.key});

  @override
  State<Exercise17Page> createState() => _Exercise17PageState();
}

class _Exercise17PageState extends State<Exercise17Page> {
  final TextEditingController controller = TextEditingController(text: '10');
  Stream<int>? stream;
  String? error;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void start() {
    final int? value = int.tryParse(controller.text.trim());
    if (value == null || value < 0 || value > 60) {
      setState(() {
        stream = null;
        error = 'Nhập số bắt đầu từ 0 đến 60.';
      });
      return;
    }
    setState(() {
      error = null;
      stream = _createCountdownStream(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _LabPage(
      children: <Widget>[
        _LabSection(
          title: 'Thiết lập Stream',
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: _compactInput('Bắt đầu từ'),
                ),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: start,
                icon: const Icon(Icons.timer_outlined),
                label: const Text('Bắt đầu'),
              ),
            ],
          ),
        ),
        if (error != null)
          _ResultPanel(value: error, error: true)
        else
          StreamBuilder<int>(
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              final bool done =
                  snapshot.connectionState == ConnectionState.done;
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 34),
                decoration: BoxDecoration(
                  color: const Color(0xFF111820),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF29323D)),
                ),
                child: Column(
                  children: <Widget>[
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        done
                            ? 'Kết thúc!'
                            : snapshot.hasData
                            ? '${snapshot.data}'
                            : '—',
                        key: ValueKey<Object?>(done ? 'done' : snapshot.data),
                        style: TextStyle(
                          color: done
                              ? const Color(0xFFFF8A5B)
                              : const Color(0xFFF2F5F7),
                          fontSize: done ? 30 : 64,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Stream.periodic • mỗi 1 giây',
                      style: TextStyle(color: Color(0xFF748091)),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}

class _Student {
  const _Student({
    required this.name,
    required this.score,
    required this.major,
  });

  final String name;
  final double score;
  final String major;
}

class Exercise18Page extends StatelessWidget {
  const Exercise18Page({super.key});

  String analyzeStudents() {
    final List<_Student> students = <_Student>[
      const _Student(name: 'An', score: 8.5, major: 'CNTT'),
      const _Student(name: 'Bình', score: 7.2, major: 'CNTT'),
      const _Student(name: 'Chi', score: 9.1, major: 'CNTT'),
      const _Student(name: 'Dũng', score: 8.8, major: 'Kinh tế'),
      const _Student(name: 'Hà', score: 8.9, major: 'CNTT'),
      const _Student(name: 'Lan', score: 8.2, major: 'CNTT'),
    ];

    final List<_Student> qualified = students
        .where(
          (_Student student) => student.major == 'CNTT' && student.score >= 8.0,
        )
        .toList();
    qualified.sort(
      (_Student first, _Student second) => second.score.compareTo(first.score),
    );
    final List<String> topThree = qualified
        .take(3)
        .map((_Student student) => student.name)
        .toList();
    final double total = students
        .map((_Student student) => student.score)
        .reduce((double sum, double score) => sum + score);

    return 'Sinh viên CNTT đạt từ 8.0: '
        '${qualified.map((_Student student) => '${student.name} (${student.score})').join(', ')}\n'
        'Top 3: ${topThree.join(', ')}\n'
        'Điểm trung bình: ${(total / students.length).toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return _StaticRunner(
      buttonLabel: 'Phân tích danh sách',
      description: 'Chỉ dùng where, sort, take, map và reduce.',
      calculate: analyzeStudents,
    );
  }
}

class _Book {
  const _Book({
    required this.id,
    required this.title,
    required this.author,
    required this.year,
  });

  final String id;
  final String title;
  final String author;
  final int year;

  String encode() => '$id|$title|$author|$year';

  factory _Book.decode(String line) {
    final List<String> parts = line.split('|');
    if (parts.length != 4) {
      throw const FormatException('Dòng sách không đúng định dạng.');
    }
    return _Book(
      id: parts[0],
      title: parts[1],
      author: parts[2],
      year: int.parse(parts[3]),
    );
  }
}

class Exercise19Page extends StatefulWidget {
  const Exercise19Page({super.key});

  @override
  State<Exercise19Page> createState() => _Exercise19PageState();
}

class _Exercise19PageState extends State<Exercise19Page> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final List<_Book> books = <_Book>[];
  final File file = File('books.txt');
  String? message;
  bool error = false;

  @override
  void dispose() {
    idController.dispose();
    titleController.dispose();
    authorController.dispose();
    yearController.dispose();
    searchController.dispose();
    super.dispose();
  }

  List<_Book> get visibleBooks {
    final String keyword = searchController.text.trim().toLowerCase();
    if (keyword.isEmpty) {
      return books;
    }
    return books
        .where(
          (_Book book) =>
              book.title.toLowerCase().contains(keyword) ||
              book.author.toLowerCase().contains(keyword),
        )
        .toList();
  }

  void addBook() {
    final String id = idController.text.trim();
    final String title = titleController.text.trim();
    final String author = authorController.text.trim();
    final int? year = int.tryParse(yearController.text.trim());

    if (id.isEmpty ||
        title.isEmpty ||
        author.isEmpty ||
        year == null ||
        year < 1 ||
        id.contains('|') ||
        title.contains('|') ||
        author.contains('|')) {
      setState(() {
        message = 'Thông tin sách chưa hợp lệ.';
        error = true;
      });
      return;
    }
    if (books.any((_Book book) => book.id == id)) {
      setState(() {
        message = 'Mã sách $id đã tồn tại.';
        error = true;
      });
      return;
    }

    setState(() {
      books.add(_Book(id: id, title: title, author: author, year: year));
      idController.clear();
      titleController.clear();
      authorController.clear();
      yearController.clear();
      message = 'Đã thêm "$title".';
      error = false;
    });
  }

  Future<void> saveBooks() async {
    try {
      await file.writeAsString(
        books.map((_Book book) => book.encode()).join('\n'),
      );
      if (!mounted) {
        return;
      }
      setState(() {
        message = 'Đã lưu ${books.length} sách vào ${file.absolute.path}.';
        error = false;
      });
    } on Object catch (exception) {
      if (!mounted) {
        return;
      }
      setState(() {
        message = 'Không thể ghi file: $exception';
        error = true;
      });
    }
  }

  Future<void> loadBooks() async {
    try {
      if (!await file.exists()) {
        throw const FileSystemException('File books.txt chưa tồn tại.');
      }
      final List<String> lines = await file.readAsLines();
      final List<_Book> loaded = <_Book>[];
      for (final String line in lines) {
        if (line.trim().isNotEmpty) {
          loaded.add(_Book.decode(line));
        }
      }
      if (!mounted) {
        return;
      }
      setState(() {
        books
          ..clear()
          ..addAll(loaded);
        message = 'Đã đọc ${books.length} sách từ file.';
        error = false;
      });
    } on Object catch (exception) {
      if (!mounted) {
        return;
      }
      setState(() {
        message = exception.toString();
        error = true;
      });
    }
  }

  void removeBook(String id) {
    setState(() {
      books.removeWhere((_Book book) => book.id == id);
      message = 'Đã xóa sách $id.';
      error = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<_Book> displayedBooks = visibleBooks;

    return _LabPage(
      children: <Widget>[
        _LabSection(
          title: 'Thông tin sách',
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: idController,
                      decoration: _compactInput('Mã sách'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: titleController,
                      decoration: _compactInput('Tên sách'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: authorController,
                      decoration: _compactInput('Tác giả'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: yearController,
                      keyboardType: TextInputType.number,
                      decoration: _compactInput('Năm xuất bản'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _InlineActions(
                children: <Widget>[
                  FilledButton.icon(
                    onPressed: addBook,
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Thêm sách'),
                  ),
                  OutlinedButton.icon(
                    onPressed: saveBooks,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('Lưu books.txt'),
                  ),
                  OutlinedButton.icon(
                    onPressed: loadBooks,
                    icon: const Icon(Icons.folder_open_outlined),
                    label: const Text('Đọc books.txt'),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (message != null) ...<Widget>[
          _ResultPanel(value: message, error: error, emptyMessage: ''),
          const SizedBox(height: 24),
        ],
        _LabSection(
          title: 'Danh sách sách (${books.length})',
          child: Column(
            children: <Widget>[
              TextField(
                controller: searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  labelText: 'Tìm theo tên hoặc tác giả',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: searchController.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            searchController.clear();
                            setState(() {});
                          },
                          icon: const Icon(Icons.close_rounded),
                        ),
                ),
              ),
              const SizedBox(height: 14),
              if (displayedBooks.isEmpty)
                const _ResultPanel(
                  value: null,
                  emptyMessage: 'Không có sách phù hợp.',
                )
              else
                ...displayedBooks.map(
                  (_Book book) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 42,
                      height: 42,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF171E27),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        book.id,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFFFF8A5B),
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    title: Text(book.title),
                    subtitle: Text('${book.author} • ${book.year}'),
                    trailing: IconButton(
                      onPressed: () => removeBook(book.id),
                      icon: const Icon(Icons.delete_outline_rounded),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<double> _fetchExchangeRate({required bool fail}) async {
  await Future<void>.delayed(const Duration(seconds: 1));
  if (fail) {
    throw Exception('API không phản hồi.');
  }
  return 25500;
}

class Exercise20Page extends StatefulWidget {
  const Exercise20Page({super.key});

  @override
  State<Exercise20Page> createState() => _Exercise20PageState();
}

class _Exercise20PageState extends State<Exercise20Page> {
  final TextEditingController controller = TextEditingController(text: '100');
  bool simulateFailure = false;
  bool loading = false;
  String? result;
  bool error = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> convert() async {
    final double? usd = double.tryParse(controller.text.trim());
    if (usd == null || usd < 0) {
      setState(() {
        result = 'Số tiền USD phải là số không âm.';
        error = true;
      });
      return;
    }

    setState(() {
      loading = true;
      result = null;
      error = false;
    });

    double rate;
    String source;
    try {
      rate = await _fetchExchangeRate(fail: simulateFailure);
      source = 'API giả lập';
    } catch (_) {
      rate = 23000;
      source = 'Tỷ giá dự phòng';
    }

    if (!mounted) {
      return;
    }
    setState(() {
      loading = false;
      result =
          'Nguồn: $source\n'
          'Tỷ giá: ${rate.toStringAsFixed(0)} VND/USD\n'
          '${usd.toStringAsFixed(2)} USD = '
          '${(usd * rate).toStringAsFixed(0)} VND';
    });
  }

  @override
  Widget build(BuildContext context) {
    return _LabPage(
      children: <Widget>[
        _LabSection(
          title: 'Thông tin quy đổi',
          child: Column(
            children: <Widget>[
              TextField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: _compactInput('Số tiền USD'),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Giả lập API lỗi'),
                subtitle: const Text('Bật để kiểm tra tỷ giá dự phòng 23000.'),
                value: simulateFailure,
                onChanged: loading
                    ? null
                    : (bool value) => setState(() => simulateFailure = value),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: FilledButton.icon(
                  onPressed: loading ? null : convert,
                  icon: loading
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.currency_exchange_rounded),
                  label: Text(loading ? 'Đang lấy tỷ giá' : 'Đổi sang VND'),
                ),
              ),
            ],
          ),
        ),
        _LabSection(
          title: 'Kết quả',
          child: _ResultPanel(
            value: result,
            error: error,
            emptyMessage: loading
                ? 'Đang gọi API giả lập.'
                : 'Chưa thực hiện quy đổi.',
          ),
        ),
      ],
    );
  }
}
