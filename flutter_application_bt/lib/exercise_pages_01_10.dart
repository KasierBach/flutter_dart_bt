part of 'exercise_pages.dart';

class Exercise01Page extends StatelessWidget {
  const Exercise01Page({super.key});

  String calculate(String input) {
    final int? n = int.tryParse(input.trim());
    if (n == null || n < 1) {
      throw const FormatException('Vui lòng nhập số nguyên dương.');
    }

    int total = 0;
    final List<int> matched = <int>[];
    for (int number = 1; number <= n; number++) {
      if (number % 3 == 0) {
        total += number;
        matched.add(number);
      }
    }

    return 'Các số phù hợp: ${matched.join(', ')}\nTổng = $total';
  }

  @override
  Widget build(BuildContext context) {
    return _SingleInputRunner(
      label: 'Số nguyên dương n',
      hint: 'Ví dụ: 10',
      initialValue: '10',
      keyboardType: TextInputType.number,
      calculate: calculate,
      actionLabel: 'Tính tổng',
    );
  }
}

class Exercise02Page extends StatelessWidget {
  const Exercise02Page({super.key});

  String calculate(String input) {
    for (int index = 0; index < input.length ~/ 2; index++) {
      final int opposite = input.length - 1 - index;
      if (input[index] != input[opposite]) {
        return 'false\n"$input" không phải chuỗi đối xứng.';
      }
    }
    return 'true\n"$input" là chuỗi đối xứng.';
  }

  @override
  Widget build(BuildContext context) {
    return _SingleInputRunner(
      label: 'Chuỗi cần kiểm tra',
      hint: 'Ví dụ: racecar',
      initialValue: 'racecar',
      calculate: calculate,
      actionLabel: 'Kiểm tra',
    );
  }
}

class Exercise03Page extends StatelessWidget {
  const Exercise03Page({super.key});

  String buildTable() {
    final StringBuffer output = StringBuffer();
    for (int multiplier = 1; multiplier <= 10; multiplier++) {
      for (int table = 2; table <= 9; table++) {
        output.write(
          '$table x $multiplier = ${table * multiplier}'.padRight(14),
        );
      }
      if (multiplier < 10) {
        output.writeln();
      }
    }
    return output.toString();
  }

  @override
  Widget build(BuildContext context) {
    return _StaticRunner(
      buttonLabel: 'In bảng cửu chương',
      description: 'Kết quả được căn cột bằng padRight(14).',
      calculate: buildTable,
    );
  }
}

class Exercise04Page extends StatefulWidget {
  const Exercise04Page({super.key});

  @override
  State<Exercise04Page> createState() => _Exercise04PageState();
}

class _Exercise04PageState extends State<Exercise04Page> {
  final TextEditingController controller = TextEditingController();
  final List<String> todos = <String>[];
  String? message;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void addTodo() {
    final String value = controller.text.trim();
    if (value.isEmpty) {
      setState(() => message = 'Tên công việc không được để trống.');
      return;
    }
    setState(() {
      todos.add(value);
      controller.clear();
      message = 'Đã thêm "$value".';
    });
  }

  void removeTodo(String value) {
    setState(() {
      todos.remove(value);
      message = 'Đã xóa "$value".';
    });
  }

  @override
  Widget build(BuildContext context) {
    return _LabPage(
      children: <Widget>[
        _LabSection(
          title: 'Thêm công việc',
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller,
                  onSubmitted: (_) => addTodo(),
                  decoration: _compactInput(
                    'Tên công việc',
                    hint: 'Ví dụ: Học vòng lặp Dart',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: addTodo,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Thêm'),
              ),
            ],
          ),
        ),
        if (message != null) ...<Widget>[
          _ResultPanel(value: message, emptyMessage: ''),
          const SizedBox(height: 24),
        ],
        _LabSection(
          title: 'Danh sách công việc (${todos.length})',
          child: todos.isEmpty
              ? const _ResultPanel(
                  value: null,
                  emptyMessage: 'Danh sách đang trống.',
                )
              : Column(
                  children: todos.indexed.map(((int, String) entry) {
                    final (int index, String todo) = entry;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131A22),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF29323D)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '${index + 1}'.padLeft(2, '0'),
                            style: const TextStyle(
                              color: Color(0xFFFF8A5B),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(child: Text(todo)),
                          IconButton(
                            tooltip: 'Xóa',
                            onPressed: () => removeTodo(todo),
                            icon: const Icon(Icons.close_rounded),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }
}

class Exercise05Page extends StatelessWidget {
  const Exercise05Page({super.key});

  int findSecondLargest(List<int> numbers) {
    int? largest;
    int? secondLargest;

    for (final int number in numbers) {
      if (largest == null || number > largest) {
        secondLargest = largest;
        largest = number;
      } else if (number < largest &&
          (secondLargest == null || number > secondLargest)) {
        secondLargest = number;
      }
    }

    if (secondLargest == null) {
      throw const FormatException('Cần ít nhất hai giá trị khác nhau.');
    }
    return secondLargest;
  }

  String calculate(String input) {
    final List<int> values = _parseIntegerList(input);
    return 'Danh sách: $values\nSố lớn thứ hai: ${findSecondLargest(values)}';
  }

  @override
  Widget build(BuildContext context) {
    return _SingleInputRunner(
      label: 'Danh sách số nguyên',
      hint: 'Các số cách nhau bằng dấu cách hoặc dấu phẩy',
      initialValue: '5 1 8 3 8 2',
      calculate: calculate,
      actionLabel: 'Tìm số lớn thứ hai',
    );
  }
}

class Exercise06Page extends StatelessWidget {
  const Exercise06Page({super.key});

  int fibonacciNormal(int n) {
    if (n <= 1) {
      return n;
    }
    return fibonacciNormal(n - 1) + fibonacciNormal(n - 2);
  }

  int fibonacciMemo(int n, Map<int, int> cache) {
    if (cache.containsKey(n)) {
      return cache[n]!;
    }
    final int result =
        fibonacciMemo(n - 1, cache) + fibonacciMemo(n - 2, cache);
    cache[n] = result;
    return result;
  }

  String calculate(String input) {
    final int? n = int.tryParse(input.trim());
    if (n == null || n < 0 || n > 40) {
      throw const FormatException('Vui lòng nhập n từ 0 đến 40.');
    }

    final Stopwatch normalWatch = Stopwatch()..start();
    final int normalResult = fibonacciNormal(n);
    normalWatch.stop();

    final Map<int, int> cache = <int, int>{0: 0, 1: 1};
    final Stopwatch memoWatch = Stopwatch()..start();
    final int memoResult = fibonacciMemo(n, cache);
    memoWatch.stop();

    return 'Fibonacci($n) = $normalResult\n'
        'Đệ quy thường: ${normalWatch.elapsedMicroseconds} µs\n'
        'Memoization: ${memoWatch.elapsedMicroseconds} µs\n'
        'Kết quả giống nhau: ${normalResult == memoResult}';
  }

  @override
  Widget build(BuildContext context) {
    return _SingleInputRunner(
      label: 'Vị trí Fibonacci n',
      hint: 'Từ 0 đến 40',
      initialValue: '35',
      keyboardType: TextInputType.number,
      calculate: calculate,
      actionLabel: 'So sánh thời gian',
    );
  }
}

class Exercise07Page extends StatefulWidget {
  const Exercise07Page({super.key});

  @override
  State<Exercise07Page> createState() => _Exercise07PageState();
}

class _Exercise07PageState extends State<Exercise07Page> {
  final TextEditingController firstController = TextEditingController(
    text: '1 2 3 4 5',
  );
  final TextEditingController secondController = TextEditingController(
    text: '3 4 5 6 7',
  );
  String? result;
  bool error = false;

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    super.dispose();
  }

  void calculate() {
    try {
      final Set<int> first = _parseIntegerList(firstController.text).toSet();
      final Set<int> second = _parseIntegerList(secondController.text).toSet();
      setState(() {
        result =
            'Hợp: ${first.union(second).toList()}\n'
            'Giao: ${first.intersection(second).toList()}';
        error = false;
      });
    } catch (exception) {
      setState(() {
        result = exception.toString().replaceFirst('FormatException: ', '');
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _LabPage(
      children: <Widget>[
        _LabSection(
          title: 'Hai danh sách số nguyên',
          child: Column(
            children: <Widget>[
              TextField(
                controller: firstController,
                decoration: _compactInput('Danh sách 1'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: secondController,
                decoration: _compactInput('Danh sách 2'),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: FilledButton.icon(
            onPressed: calculate,
            icon: const Icon(Icons.join_inner_rounded),
            label: const Text('Tính hợp và giao'),
          ),
        ),
        const SizedBox(height: 28),
        _LabSection(
          title: 'Kết quả',
          child: _ResultPanel(value: result, error: error),
        ),
      ],
    );
  }
}

class Exercise08Page extends StatelessWidget {
  const Exercise08Page({super.key});

  String calculate(String input) {
    final Map<String, int> frequency = <String, int>{};
    for (final String word in input.toLowerCase().split(' ')) {
      if (word.isNotEmpty) {
        frequency[word] = (frequency[word] ?? 0) + 1;
      }
    }

    if (frequency.isEmpty) {
      throw const FormatException('Câu không được để trống.');
    }

    return frequency.entries
        .map((MapEntry<String, int> entry) => '${entry.key}: ${entry.value}')
        .join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return _SingleInputRunner(
      label: 'Nhập một câu',
      hint: 'Các từ cách nhau bằng dấu cách',
      initialValue: 'Dart is fun and Dart is easy',
      maxLines: 3,
      calculate: calculate,
      actionLabel: 'Đếm tần suất',
    );
  }
}

class _UiProduct {
  const _UiProduct({required this.id, required this.name, required this.price});

  final String id;
  final String name;
  final double price;
}

class Exercise09Page extends StatefulWidget {
  const Exercise09Page({super.key});

  @override
  State<Exercise09Page> createState() => _Exercise09PageState();
}

class _Exercise09PageState extends State<Exercise09Page> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final List<_UiProduct> items = <_UiProduct>[];
  String? message;
  bool error = false;

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  double get total {
    double value = 0;
    for (final _UiProduct product in items) {
      value += product.price;
    }
    return value;
  }

  void addProduct() {
    final String id = idController.text.trim();
    final String name = nameController.text.trim();
    final double? price = double.tryParse(priceController.text.trim());

    if (id.isEmpty || name.isEmpty || price == null || price < 0) {
      setState(() {
        message = 'Hãy nhập đủ mã, tên và giá hợp lệ.';
        error = true;
      });
      return;
    }

    setState(() {
      items.add(_UiProduct(id: id, name: name, price: price));
      idController.clear();
      nameController.clear();
      priceController.clear();
      message = 'Đã thêm $name.';
      error = false;
    });
  }

  void removeProduct(String id) {
    setState(() {
      items.removeWhere((_UiProduct product) => product.id == id);
      message = 'Đã xóa sản phẩm có mã $id.';
      error = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _LabPage(
      children: <Widget>[
        _LabSection(
          title: 'Thêm sản phẩm',
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: idController,
                      decoration: _compactInput('Mã sản phẩm'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: nameController,
                      decoration: _compactInput('Tên sản phẩm'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: _compactInput('Giá'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  FilledButton.icon(
                    onPressed: addProduct,
                    icon: const Icon(Icons.add_shopping_cart_rounded),
                    label: const Text('Thêm vào giỏ'),
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
          title: 'Giỏ hàng (${items.length})',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (items.isEmpty)
                const _ResultPanel(
                  value: null,
                  emptyMessage: 'Chưa có sản phẩm trong giỏ.',
                )
              else
                ...items.map(
                  (_UiProduct product) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(product.name),
                    subtitle: Text(product.id),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('${product.price.toStringAsFixed(0)} đ'),
                        IconButton(
                          onPressed: () => removeProduct(product.id),
                          icon: const Icon(Icons.delete_outline_rounded),
                        ),
                      ],
                    ),
                  ),
                ),
              const Divider(height: 24),
              Text(
                'Tổng tiền: ${total.toStringAsFixed(0)} đ',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFFFF8A5B),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Exercise10Page extends StatefulWidget {
  const Exercise10Page({super.key});

  @override
  State<Exercise10Page> createState() => _Exercise10PageState();
}

class _Exercise10PageState extends State<Exercise10Page> {
  final TextEditingController controller = TextEditingController();
  final List<String> stack = <String>[];
  String? result;
  bool error = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void push() {
    final String value = controller.text.trim();
    if (value.isEmpty) {
      setState(() {
        result = 'Giá trị không được để trống.';
        error = true;
      });
      return;
    }
    setState(() {
      stack.add(value);
      controller.clear();
      result = 'push("$value")';
      error = false;
    });
  }

  void pop() {
    if (stack.isEmpty) {
      setState(() {
        result = 'Không thể pop vì Stack đang rỗng.';
        error = true;
      });
      return;
    }
    setState(() {
      result = 'pop() trả về "${stack.removeLast()}"';
      error = false;
    });
  }

  void peek() {
    setState(() {
      if (stack.isEmpty) {
        result = 'Không thể peek vì Stack đang rỗng.';
        error = true;
      } else {
        result = 'peek() trả về "${stack.last}"';
        error = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _LabPage(
      children: <Widget>[
        _LabSection(
          title: 'Thao tác với Stack<String>',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: controller,
                onSubmitted: (_) => push(),
                decoration: _compactInput('Giá trị cần push'),
              ),
              const SizedBox(height: 12),
              _InlineActions(
                children: <Widget>[
                  FilledButton(onPressed: push, child: const Text('push')),
                  OutlinedButton(onPressed: pop, child: const Text('pop')),
                  OutlinedButton(onPressed: peek, child: const Text('peek')),
                ],
              ),
            ],
          ),
        ),
        _LabSection(
          title: 'Trạng thái',
          child: _ResultPanel(
            value: result == null
                ? null
                : '$result\nStack: $stack\n'
                      'size(): ${stack.length}\n'
                      'isEmpty(): ${stack.isEmpty}',
            error: error,
            emptyMessage: 'Stack: []\nsize(): 0\nisEmpty(): true',
          ),
        ),
      ],
    );
  }
}
