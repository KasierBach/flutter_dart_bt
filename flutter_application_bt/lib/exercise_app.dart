import 'package:flutter/material.dart';

import 'exercise_pages.dart';

void runExerciseApp() {
  runApp(const ExerciseApp());
}

class ExerciseApp extends StatelessWidget {
  const ExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '20 bài tập Dart',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      home: const ExerciseDashboard(),
    );
  }
}

class ExerciseDefinition {
  const ExerciseDefinition(this.number, this.title, this.builder);

  final int number;
  final String title;
  final WidgetBuilder builder;
}

final List<ExerciseDefinition> exerciseDefinitions = <ExerciseDefinition>[
  ExerciseDefinition(1, 'Tổng chia hết cho 3', (_) => const Exercise01Page()),
  ExerciseDefinition(2, 'Chuỗi đối xứng', (_) => const Exercise02Page()),
  ExerciseDefinition(3, 'Bảng cửu chương', (_) => const Exercise03Page()),
  ExerciseDefinition(4, 'Todo List', (_) => const Exercise04Page()),
  ExerciseDefinition(5, 'Số lớn thứ hai', (_) => const Exercise05Page()),
  ExerciseDefinition(6, 'Fibonacci có bộ nhớ', (_) => const Exercise06Page()),
  ExerciseDefinition(7, 'Hợp và giao danh sách', (_) => const Exercise07Page()),
  ExerciseDefinition(8, 'Đếm tần suất từ', (_) => const Exercise08Page()),
  ExerciseDefinition(9, 'Sản phẩm và giỏ hàng', (_) => const Exercise09Page()),
  ExerciseDefinition(10, 'Stack Generic', (_) => const Exercise10Page()),
  ExerciseDefinition(11, 'Đa hình phương tiện', (_) => const Exercise11Page()),
  ExerciseDefinition(
    12,
    'Mixin Logger và Validator',
    (_) => const Exercise12Page(),
  ),
  ExerciseDefinition(13, 'Singleton Database', (_) => const Exercise13Page()),
  ExerciseDefinition(14, 'Enum và Extension', (_) => const Exercise14Page()),
  ExerciseDefinition(
    15,
    'Xử lý ngoại lệ nhập liệu',
    (_) => const Exercise15Page(),
  ),
  ExerciseDefinition(
    16,
    'Future và Async/Await',
    (_) => const Exercise16Page(),
  ),
  ExerciseDefinition(17, 'Stream đếm ngược', (_) => const Exercise17Page()),
  ExerciseDefinition(18, 'Danh sách sinh viên', (_) => const Exercise18Page()),
  ExerciseDefinition(19, 'Quản lý thư viện', (_) => const Exercise19Page()),
  ExerciseDefinition(20, 'Đổi USD sang VND', (_) => const Exercise20Page()),
];

class ExerciseDashboard extends StatefulWidget {
  const ExerciseDashboard({super.key});

  @override
  State<ExerciseDashboard> createState() => _ExerciseDashboardState();
}

class _ExerciseDashboardState extends State<ExerciseDashboard> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ExerciseDefinition selected = exerciseDefinitions[selectedIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('20 bài tập Dart')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<int>(
              key: const Key('exercise-selector'),
              initialValue: selectedIndex,
              decoration: const InputDecoration(
                labelText: 'Chọn bài cần chạy',
                border: OutlineInputBorder(),
              ),
              items: exerciseDefinitions.indexed.map((
                (int, ExerciseDefinition) entry,
              ) {
                final (int index, ExerciseDefinition exercise) = entry;
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text('Bài ${exercise.number}: ${exercise.title}'),
                );
              }).toList(),
              onChanged: (int? value) {
                if (value != null) {
                  setState(() => selectedIndex = value);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bài ${selected.number}: ${selected.title}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          const Divider(height: 24),
          Expanded(child: Builder(builder: selected.builder)),
        ],
      ),
    );
  }
}
