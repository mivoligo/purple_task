// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get aboutAppViewTitle => 'Om Purple Task';

  @override
  String get addCategoryButton => 'Tilføj kategori';

  @override
  String get addNewTaskInputPlaceholder => 'Tilføj ny opgave';

  @override
  String get allTasksHeader => 'Alle';

  @override
  String get appDescription => 'Simpel to-do app til at hjælpe med at få ting klaret';

  @override
  String get cancelButton => 'Annuller';

  @override
  String get category => 'Kategori';

  @override
  String get categoryNameLabel => 'Navn';

  @override
  String get categoryOptionChangeColor => 'Ændre farve';

  @override
  String get categoryOptionChangeIcon => 'Ændre ikon';

  @override
  String get categoryOptionChangeName => 'Ændre navn';

  @override
  String get categoryOptionDeleteAllTasks => 'Slet alle opgaver';

  @override
  String get categoryOptionDeleteCategory => 'Slet kategori';

  @override
  String categoryTasksInfo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count opgaver tilbage',
      one: '1 opgave tilbage',
      zero: 'Ingen opgaver tilbage',
    );
    return '$_temp0';
  }

  @override
  String get categoryOptionDeleteCompleted => 'Slet udførte opgaver';

  @override
  String get changeCategoryColorDialogTitle => 'Ændre farve på kategori';

  @override
  String get changeCategoryIconDialogTitle => 'Ændre ikon på kategori';

  @override
  String get changeCategoryNameDialogTitle => 'Ændre navn på kategori';

  @override
  String get changeTaskName => 'Ændre navn på opgave';

  @override
  String get closeButton => 'Luk';

  @override
  String get completedEarlierTasksHeader => 'Tidligere udført';

  @override
  String get completedTasksHeader => 'Udført';

  @override
  String get completedTodayTasksHeader => 'Udført i dag';

  @override
  String get completedYesterdayTasksHeader => 'Udført i går';

  @override
  String get continueButton => 'Fortsæt';

  @override
  String get customDate => 'Brugerdefineret dato';

  @override
  String get delete => 'Slet';

  @override
  String get deleteAllTasksDialogContent => 'Alle opgaver i denne kateogiry vil blive slettet';

  @override
  String get deleteAllTasksDialogTitle => 'Slet alle opgaver?';

  @override
  String deleteCategoryDialogContent(Object categoryName) {
    return 'Denne kategori ($categoryName) og alle opgaver i den vil blive slettet';
  }

  @override
  String get deleteCategoryDialogTitle => 'Slet kategori?';

  @override
  String get deleteCompletedTasksDialogContent => 'Alle opgaver markeret som udført i denne kategori vil blive slettet';

  @override
  String get deleteCompletedTasksDialogTitle => 'Slet udførte opgaver?';

  @override
  String get dueDate => 'Forfaldsdato';

  @override
  String get errorInformation => 'En fejl opstod!';

  @override
  String get finishButton => 'Afslut';

  @override
  String get greetings => 'Hej';

  @override
  String get hideCategoriesButton => 'Skjul kategorier';

  @override
  String get later => 'Senere';

  @override
  String get license => 'Licens';

  @override
  String get newCategoryColorLabel => 'Farve';

  @override
  String get newCategoryIconLabel => 'Ikon';

  @override
  String get newCategoryLabel => 'Ny kategori';

  @override
  String get newCategoryTasksInfo => 'Du kan tilføje nogle opgaver nu, eller gøre det senere efter at have færdiggjort opretningen af kategorien.';

  @override
  String get nextButton => 'Næste';

  @override
  String get noCategoryHeader => 'Ukategoriseret';

  @override
  String get noDate => 'Ingen dato';

  @override
  String get overdueTasksHeader => 'Forfaldne';

  @override
  String get reportIssuesButton => 'Reportér problemer';

  @override
  String get saveButton => 'Gem';

  @override
  String get setDueDate => 'Sæt forfaldsdato';

  @override
  String get settings => 'Indstillinger';

  @override
  String get settingsOptionDateFormat => 'Datoformat';

  @override
  String get settingsOptionDisplayTimeCompleted => 'Vis tidspunkt for opgavens udførelse';

  @override
  String get settingsOptionLanguage => 'Sprog';

  @override
  String get settingsOptionThemeMode => 'Tema';

  @override
  String get settingsOptionTimeFormat => 'Tidsformat';

  @override
  String get showCategoriesButton => 'Vis kategorier';

  @override
  String get showOptions => 'Vis muligheder';

  @override
  String get sourceCode => 'Se kildekoden';

  @override
  String get task => 'Opgave';

  @override
  String get taskOptionMoveToCategory => 'Flyt til kategori';

  @override
  String get themeModeDark => 'Mørk';

  @override
  String get themeModeLight => 'Lys';

  @override
  String get themeModeSystem => 'System';

  @override
  String get toDoTasksHeader => 'To Do';

  @override
  String get today => 'I dag';

  @override
  String get tomorrow => 'I morgen';

  @override
  String totalTasksInfo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Du har $count opgaver at udføre',
      one: 'Du har 1 opgave at udføre',
      zero: 'Intet at lave... Perfekt!',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'I går';
}
