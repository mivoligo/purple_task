import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purple_task/ui/ui.dart';

void main() {
  testWidgets('finds Column widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CategoryHeader(
        title: '',
        description: '',
        progress: 0,
        color: Colors.black,
      ),
    ));
    final column = find.byType(Column);
    expect(column, findsOneWidget);
  });

  testWidgets('finds AnimatedProgressBar widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CategoryHeader(
        title: '',
        description: '',
        progress: 0,
        color: Colors.black,
      ),
    ));
    final animatedProgressBar = find.byType(AnimatedProgressBar);
    expect(animatedProgressBar, findsOneWidget);
  });

  testWidgets('should have title and description', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CategoryHeader(
        title: 'title',
        description: 'description',
        progress: 0,
        color: Colors.black,
      ),
    ));
    final title = find.text('title');
    final description = find.text('description');
    expect(title, findsOneWidget);
    expect(description, findsOneWidget);
  });

  testWidgets('should have text % same as progress',
      (WidgetTester tester) async {
    final progressValue = 0.4843;
    await tester.pumpWidget(MaterialApp(
      home: CategoryHeader(
        title: 'title',
        description: 'description',
        progress: progressValue,
        color: Colors.black,
      ),
    ));
    final progressText = find.text('48%');
    expect(progressText, findsOneWidget);
  });
}
