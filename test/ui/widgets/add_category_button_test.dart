import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purple_task/ui/ui.dart';

void main() {
  testWidgets('finds FlatButton widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: AddCategoryButton(text: '', opacity: 0, onPressed: null)));
    final button = find.byType(FlatButton);
    expect(button, findsOneWidget);
  });

  testWidgets('should have text', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: AddCategoryButton(text: 'label', opacity: 0, onPressed: null)));
    final text = find.text('label');
    expect(text, findsOneWidget);
  });

  testWidgets('onPressed callback should fail when opacity < 1',
      (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(MaterialApp(
        home: AddCategoryButton(
            text: '', opacity: 0.5, onPressed: () => pressed = true)));
    final button = find.byType(FlatButton);
    await tester.tap(button);
    expect(pressed, false);
  });

  testWidgets('onPressed callback should work when opacity == 1',
      (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(MaterialApp(
        home: AddCategoryButton(
            text: '', opacity: 1, onPressed: () => pressed = true)));
    final button = find.byType(FlatButton);
    await tester.tap(button);
    expect(pressed, true);
  });
}
