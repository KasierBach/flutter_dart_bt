import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_bt/exercise_app.dart';

void main() {
  testWidgets('chọn và chạy bài tập', (WidgetTester tester) async {
    await tester.pumpWidget(const ExerciseApp());

    expect(exerciseDefinitions, hasLength(20));
    expect(find.text('20 bài tập Dart'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('single-input')), '10');
    await tester.tap(find.byKey(const Key('run-exercise')));
    await tester.pump();
    expect(find.textContaining('Tổng = 18'), findsOneWidget);

    await tester.tap(find.byKey(const Key('exercise-selector')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bài 2: Chuỗi đối xứng'));
    await tester.pumpAndSettle();

    expect(find.text('Bài 2: Chuỗi đối xứng'), findsWidgets);
    expect(find.text('Kiểm tra'), findsOneWidget);
  });
}
