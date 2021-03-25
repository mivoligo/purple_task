import 'package:flutter_test/flutter_test.dart';
import 'package:purple_task/globals/globals.dart';
import 'package:purple_task/ui/ui.dart';

void main() {
  group('Due date', () {
    test('should return no date', () {
      final model = TaskViewModel();
      final dynamic dateInMillis = null;
      final dateFormat = 'yMd';
      expect(model.displayDueDate(dateInMillis, dateFormat), noDate);
    });
    test('should return today', () {
      final model = TaskViewModel();
      final todayDate = DateTime.now();
      final dateInMillis = todayDate.millisecondsSinceEpoch;
      final dateFormat = 'yMd';
      print(todayDate.timeZoneOffset);
      expect(model.displayDueDate(dateInMillis, dateFormat), today);
    });
    test('should return tomorrow', () {
      final model = TaskViewModel();
      final todayDate = DateTime.now();
      final tomorrowDate = todayDate.add(Duration(days: 1));
      final dateInMillis = tomorrowDate.millisecondsSinceEpoch;
      final dateFormat = 'yMd';
      expect(model.displayDueDate(dateInMillis, dateFormat), tomorrow);
    });
    test('should return 2021//08/04', () {
      final model = TaskViewModel();
      final aDate = DateTime(2021, 8, 4);
      final dateInMillis = aDate.millisecondsSinceEpoch;
      final dateFormat = 'y/MM/dd';
      expect(model.displayDueDate(dateInMillis, dateFormat), '2021/08/04');
    });
  });
}
