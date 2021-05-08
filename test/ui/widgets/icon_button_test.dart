import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purple_task/ui/ui.dart';

void main() {
  testWidgets('finds IconButton widget', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CustomIconButton(
        icon: Icon(Icons.add),
      ),
    ));
    final button = find.byType(IconButton);
    expect(button, findsOneWidget);
  });

  testWidgets('finds tooltip', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CustomIconButton(
        icon: Icon(Icons.add),
        tooltip: 'tooltip',
      ),
    ));
    final tooltip = find.byTooltip('tooltip');
    expect(tooltip, findsOneWidget);
  });

  testWidgets('onPressed callback', (tester) async {
    var pressed = false;
    await tester.pumpWidget(MaterialApp(
      home: CustomIconButton(
        icon: const Icon(Icons.add),
        onPressed: () => pressed = true,
      ),
    ));
    final button = find.byType(IconButton);
    await tester.tap(button);
    expect(pressed, true);
  });
}
