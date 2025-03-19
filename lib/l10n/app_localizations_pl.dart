// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get aboutAppViewTitle => 'O programie Purple Task';

  @override
  String get addCategoryButton => 'Dodaj kategorię';

  @override
  String get addNewTaskInputPlaceholder => 'Dodaj zadanie';

  @override
  String get allTasksHeader => 'Wszystkie';

  @override
  String get appDescription => 'Prosta aplikacja pomagająca w planowaniu zadań';

  @override
  String get cancelButton => 'Anuluj';

  @override
  String get category => 'Kategoria';

  @override
  String get categoryNameLabel => 'Nazwa';

  @override
  String get categoryOptionChangeColor => 'Zmień kolor';

  @override
  String get categoryOptionChangeIcon => 'Zmień ikonę';

  @override
  String get categoryOptionChangeName => 'Zmień nazwę';

  @override
  String get categoryOptionDeleteAllTasks => 'Usuń wszystkie zadania';

  @override
  String get categoryOptionDeleteCategory => 'Usuń kategorię';

  @override
  String categoryTasksInfo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count zadań',
      many: '$count zadań',
      few: '$count zadania',
      one: '1 zadanie',
      zero: 'Brak zadań',
    );
    return '$_temp0';
  }

  @override
  String get categoryOptionDeleteCompleted => 'Usuń ukończone zadania';

  @override
  String get changeCategoryColorDialogTitle => 'Zmień kolor kategorii';

  @override
  String get changeCategoryIconDialogTitle => 'Zmień ikonę kategorii';

  @override
  String get changeCategoryNameDialogTitle => 'Zmień nazwę kategorii';

  @override
  String get changeTaskName => 'Zmień nazwę zadania';

  @override
  String get closeButton => 'Zamknij';

  @override
  String get completedEarlierTasksHeader => 'Ukończone wcześniej';

  @override
  String get completedTasksHeader => 'Ukończone';

  @override
  String get completedTodayTasksHeader => 'Ukończone dziś';

  @override
  String get completedYesterdayTasksHeader => 'Ukończone wczoraj';

  @override
  String get continueButton => 'Dalej';

  @override
  String get customDate => 'Data niestandardowa';

  @override
  String get delete => 'Usuń';

  @override
  String get deleteAllTasksDialogContent => 'Wszystkie zadania w tej kategorii zostaną usunięte';

  @override
  String get deleteAllTasksDialogTitle => 'Usunąć wszystkie zadania?';

  @override
  String deleteCategoryDialogContent(Object categoryName) {
    return 'Ta kategoria ($categoryName) i wszystkie zadania w niej zawarte zostaną usunięte';
  }

  @override
  String get deleteCategoryDialogTitle => 'Usunąć kategorię?';

  @override
  String get deleteCompletedTasksDialogContent => 'Wszystkie ukończone zadania w tej kategorii zostaną usunięte';

  @override
  String get deleteCompletedTasksDialogTitle => 'Usunąć ukończone zadania?';

  @override
  String get dueDate => 'Termin';

  @override
  String get errorInformation => 'Wystąpił problem!';

  @override
  String get finishButton => 'Zakończ';

  @override
  String get greetings => 'Witaj';

  @override
  String get hideCategoriesButton => 'Ukryj kategorie';

  @override
  String get later => 'Później';

  @override
  String get license => 'Licencja';

  @override
  String get newCategoryColorLabel => 'Kolor';

  @override
  String get newCategoryIconLabel => 'Ikona';

  @override
  String get newCategoryLabel => 'Nowa kategoria';

  @override
  String get newCategoryTasksInfo => 'Zadania można dodać teraz lub później, po ukończeniu tworzenia kategorii.';

  @override
  String get nextButton => 'Dalej';

  @override
  String get noCategoryHeader => 'Bez kategorii';

  @override
  String get noDate => 'Bez daty';

  @override
  String get overdueTasksHeader => 'Zaległe';

  @override
  String get reportIssuesButton => 'Zgłoś problem';

  @override
  String get saveButton => 'Zapisz';

  @override
  String get setDueDate => 'Ustaw termin';

  @override
  String get settings => 'Ustawienia';

  @override
  String get settingsOptionDateFormat => 'Format daty';

  @override
  String get settingsOptionDisplayTimeCompleted => 'Wyświetlaj czas ukończenia zadania';

  @override
  String get settingsOptionLanguage => 'Język';

  @override
  String get settingsOptionThemeMode => 'Motyw';

  @override
  String get settingsOptionTimeFormat => 'Format czasu';

  @override
  String get showCategoriesButton => 'Pokaż kategorie';

  @override
  String get showOptions => 'Wyświetl opcje';

  @override
  String get sourceCode => 'Kod źródłowy';

  @override
  String get task => 'Zadanie';

  @override
  String get taskOptionMoveToCategory => 'Przenieś do innej kategorii';

  @override
  String get themeModeDark => 'Ciemny';

  @override
  String get themeModeLight => 'Jasny';

  @override
  String get themeModeSystem => 'Systemowy';

  @override
  String get toDoTasksHeader => 'Do zrobienia';

  @override
  String get today => 'Dziś';

  @override
  String get tomorrow => 'Jutro';

  @override
  String totalTasksInfo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zostało Ci $count zadań do zrobienia',
      many: 'Zostało Ci $count zadań do zrobienia',
      few: 'Zostało Ci $count zadania do zrobienia',
      one: 'Zostało Ci jedno zadanie do zrobienia',
      zero: 'Nic do zrobienia...Wspaniale!',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Wczoraj';
}
