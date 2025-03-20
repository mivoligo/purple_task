// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get aboutAppViewTitle => 'About Purple Task';

  @override
  String get addCategoryButton => 'Add category';

  @override
  String get addNewTaskInputPlaceholder => 'Add new task';

  @override
  String get allTasksHeader => 'All';

  @override
  String get appDescription => 'Simple TO-DO app to help you get stuff done';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get category => 'Category';

  @override
  String get categoryNameLabel => 'Name';

  @override
  String get categoryOptionChangeColor => 'Change color';

  @override
  String get categoryOptionChangeIcon => 'Change icon';

  @override
  String get categoryOptionChangeName => 'Change name';

  @override
  String get categoryOptionDeleteAllTasks => 'Delete all tasks';

  @override
  String get categoryOptionDeleteCategory => 'Delete category';

  @override
  String categoryTasksInfo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tasks left',
      one: '1 task left',
      zero: 'No tasks left',
    );
    return '$_temp0';
  }

  @override
  String get categoryOptionDeleteCompleted => 'Delete completed tasks';

  @override
  String get changeCategoryColorDialogTitle => 'Change color of category';

  @override
  String get changeCategoryIconDialogTitle => 'Change icon of category';

  @override
  String get changeCategoryNameDialogTitle => 'Change name of category';

  @override
  String get changeTaskName => 'Change name of task';

  @override
  String get closeButton => 'Close';

  @override
  String get completedEarlierTasksHeader => 'Completed earlier';

  @override
  String get completedTasksHeader => 'Completed';

  @override
  String get completedTodayTasksHeader => 'Completed today';

  @override
  String get completedYesterdayTasksHeader => 'Completed yesterday';

  @override
  String get continueButton => 'Continue';

  @override
  String get customDate => 'Custom date';

  @override
  String get delete => 'Delete';

  @override
  String get deleteAllTasksDialogContent => 'All tasks in this category will be deleted';

  @override
  String get deleteAllTasksDialogTitle => 'Delete all tasks?';

  @override
  String deleteCategoryDialogContent(Object categoryName) {
    return 'This category ($categoryName) and all tasks in it will be deleted';
  }

  @override
  String get deleteCategoryDialogTitle => 'Delete category?';

  @override
  String get deleteCompletedTasksDialogContent => 'All tasks marked as completed in this category will be deleted';

  @override
  String get deleteCompletedTasksDialogTitle => 'Delete completed tasks?';

  @override
  String get dueDate => 'Due date';

  @override
  String get errorInformation => 'An issue occurred!';

  @override
  String get finishButton => 'Finish';

  @override
  String get greetings => 'Hello';

  @override
  String get hideCategoriesButton => 'Hide categories';

  @override
  String get later => 'Later';

  @override
  String get license => 'License';

  @override
  String get newCategoryColorLabel => 'Color';

  @override
  String get newCategoryIconLabel => 'Icon';

  @override
  String get newCategoryLabel => 'New Category';

  @override
  String get newCategoryTasksInfo => 'You can add few tasks now or do it after finishing category creation.';

  @override
  String get nextButton => 'Next';

  @override
  String get noCategoryHeader => 'Uncategorized';

  @override
  String get noDate => 'No date';

  @override
  String get overdueTasksHeader => 'Overdue';

  @override
  String get reportIssuesButton => 'Report issues';

  @override
  String get saveButton => 'Save';

  @override
  String get setDueDate => 'Set due date';

  @override
  String get settings => 'Settings';

  @override
  String get settingsOptionDateFormat => 'Date format';

  @override
  String get settingsOptionDisplayTimeCompleted => 'Display task\'s completion time';

  @override
  String get settingsOptionLanguage => 'Language';

  @override
  String get settingsOptionThemeMode => 'Theme';

  @override
  String get settingsOptionTimeFormat => 'Time format';

  @override
  String get showCategoriesButton => 'Show categories';

  @override
  String get showOptions => 'Show options';

  @override
  String get sourceCode => 'View source code';

  @override
  String get task => 'Task';

  @override
  String get taskOptionMoveToCategory => 'Move to category';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeSystem => 'System';

  @override
  String get toDoTasksHeader => 'To Do';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String totalTasksInfo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'You have $count tasks to complete',
      one: 'You have 1 task to complete',
      zero: 'Nothing to do...Great!',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Yesterday';
}
