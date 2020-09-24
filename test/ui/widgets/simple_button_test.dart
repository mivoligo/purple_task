import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purple_task/ui/ui.dart';

void main() {
  testWidgets('finds a FlatButton widget', (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: SimpleButton(text: '', onPressed: null)));
    final button = find.byType(FlatButton);
    expect(button, findsOneWidget);
  });

  testWidgets('finds text', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: SimpleButton(
      text: 'text',
      onPressed: null,
    )));
    final text = find.text('text');
    expect(text, findsOneWidget);
  });

  testWidgets('onPressed callback', (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(MaterialApp(
        home: SimpleButton(
      text: 'text',
      onPressed: () => pressed = true,
    )));
    final button = find.byType(FlatButton);
    await tester.tap(button);
    expect(pressed, true);
  });
}
