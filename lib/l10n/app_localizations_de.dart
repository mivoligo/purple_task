// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get aboutAppViewTitle => 'Über Purple Task';

  @override
  String get addCategoryButton => 'Kategorie hinzufügen';

  @override
  String get addNewTaskInputPlaceholder => 'Neue Aufgabe hinzufügen';

  @override
  String get allTasksHeader => 'Alle';

  @override
  String get appDescription => 'Eine einfache To-do App um Aufgaben abhaken zu können';

  @override
  String get cancelButton => 'Abbrechen';

  @override
  String get category => 'Kategorie';

  @override
  String get categoryNameLabel => 'Name';

  @override
  String get categoryOptionChangeColor => 'Farbe ändern';

  @override
  String get categoryOptionChangeIcon => 'Icon ändern';

  @override
  String get categoryOptionChangeName => 'Namen ändern';

  @override
  String get categoryOptionDeleteAllTasks => 'Alle Aufgaben löschen';

  @override
  String get categoryOptionDeleteCategory => 'Kategorie löschen';

  @override
  String categoryTasksInfo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Aufgaben übrig',
      one: '1 Aufgabe übrig',
      zero: 'Keine Aufgaben übrig',
    );
    return '$_temp0';
  }

  @override
  String get categoryOptionDeleteCompleted => 'Erledigte Aufgaben löschen';

  @override
  String get changeCategoryColorDialogTitle => 'Farbe der Kategorie ändern';

  @override
  String get changeCategoryIconDialogTitle => 'Icon der Kategorie ändern';

  @override
  String get changeCategoryNameDialogTitle => 'Namen der Kategorie ändern';

  @override
  String get changeTaskName => 'Name der Aufgabe ändern';

  @override
  String get closeButton => 'Schließen';

  @override
  String get completedEarlierTasksHeader => 'Vorher erledigt';

  @override
  String get completedTasksHeader => 'Erledigt';

  @override
  String get completedTodayTasksHeader => 'Heute erledigt';

  @override
  String get completedYesterdayTasksHeader => 'Gestern erledigt';

  @override
  String get continueButton => 'Weiter';

  @override
  String get customDate => 'Benutzerdefiniertes Datum';

  @override
  String get delete => 'Löschen';

  @override
  String get deleteAllTasksDialogContent => 'Alle Aufgaben in dieser Kategorie werden gelöscht';

  @override
  String get deleteAllTasksDialogTitle => 'Alle Aufgaben löschen?';

  @override
  String deleteCategoryDialogContent(Object categoryName) {
    return 'Diese Kategorie ($categoryName) und alle darin enthaltenen Aufgaben werden gelöscht';
  }

  @override
  String get deleteCategoryDialogTitle => 'Kategorie löschen?';

  @override
  String get deleteCompletedTasksDialogContent => 'Alle als erledigt markierten Aufgaben in dieser Kategorie werden gelöscht';

  @override
  String get deleteCompletedTasksDialogTitle => 'Erledigte Aufgaben löschen?';

  @override
  String get dueDate => 'Fälligkeitsdatum';

  @override
  String get errorInformation => 'Ein Problem ist aufgetreten!';

  @override
  String get finishButton => 'Fertig';

  @override
  String get greetings => 'Hallo';

  @override
  String get hideCategoriesButton => 'Kategorien ausblenden';

  @override
  String get later => 'Später';

  @override
  String get license => 'Lizenz';

  @override
  String get newCategoryColorLabel => 'Farbe';

  @override
  String get newCategoryIconLabel => 'Symbol';

  @override
  String get newCategoryLabel => 'Neue Kategorie';

  @override
  String get newCategoryTasksInfo => 'Sie können jetzt einige Aufgaben hinzufügen oder dies nach der Kategorierstellung tun.';

  @override
  String get nextButton => 'Weiter';

  @override
  String get noCategoryHeader => 'Ohne Kategorie';

  @override
  String get noDate => 'Kein Datum';

  @override
  String get overdueTasksHeader => 'Überfällig';

  @override
  String get reportIssuesButton => 'Probleme melden';

  @override
  String get saveButton => 'Speichern';

  @override
  String get setDueDate => 'Fälligkeitsdatum festlegen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get settingsOptionDateFormat => 'Datumsformat';

  @override
  String get settingsOptionDisplayTimeCompleted => 'Abschlusszeit der Aufgabe anzeigen';

  @override
  String get settingsOptionLanguage => 'Sprache';

  @override
  String get settingsOptionThemeMode => 'Theme';

  @override
  String get settingsOptionTimeFormat => 'Zeitformat';

  @override
  String get showCategoriesButton => 'Kategorien anzeigen';

  @override
  String get showOptions => 'Optionen anzeigen';

  @override
  String get sourceCode => 'Quellcode anzeigen';

  @override
  String get task => 'Aufgabe';

  @override
  String get taskOptionMoveToCategory => 'In Kategorie verschieben';

  @override
  String get themeModeDark => 'Dunkel';

  @override
  String get themeModeLight => 'Hell';

  @override
  String get themeModeSystem => 'System';

  @override
  String get toDoTasksHeader => 'To-do';

  @override
  String get today => 'Heute';

  @override
  String get tomorrow => 'Morgen';

  @override
  String totalTasksInfo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Du hast $count Aufgaben zu erledigen',
      one: 'Du hast 1 Aufgabe zu erledigen',
      zero: 'Nichts zu tun... Super!',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Gestern';
}
