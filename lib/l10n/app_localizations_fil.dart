// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String get aboutAppViewTitle => 'Tungkol sa Purple Task';

  @override
  String get addCategoryButton => 'Magdagdag ng kategorya';

  @override
  String get addNewTaskInputPlaceholder => 'Magdagdag ng task';

  @override
  String get allTasksHeader => 'Lahat';

  @override
  String get appDescription => 'Simpleng TO-DO app para tulungan kang matapos ang gawain';

  @override
  String get cancelButton => 'Kanselahin';

  @override
  String get category => 'Kategorya';

  @override
  String get categoryNameLabel => 'Pangalan';

  @override
  String get categoryOptionChangeColor => 'Palitan ang kulay';

  @override
  String get categoryOptionChangeIcon => 'Palitan ang icon';

  @override
  String get categoryOptionChangeName => 'Palitan ang pangalan';

  @override
  String get categoryOptionDeleteAllTasks => 'Tanggalin lahat ng mga task';

  @override
  String get categoryOptionDeleteCategory => 'Tanggalin ang kategorya';

  @override
  String categoryTasksInfo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mga tasks natitira',
      one: '1 task natitira',
      zero: 'Wala nang task',
    );
    return '$_temp0';
  }

  @override
  String get categoryOptionDeleteCompleted => 'Tanggalin ang tapos na mga task';

  @override
  String get changeCategoryColorDialogTitle => 'Palitan ang kulay ng kategorya';

  @override
  String get changeCategoryIconDialogTitle => 'Palitan ang icon ng kategorya';

  @override
  String get changeCategoryNameDialogTitle => 'Palitan ang pangalan ng kategorya';

  @override
  String get changeTaskName => 'Palitan ang pangalan ng task';

  @override
  String get closeButton => 'Isara';

  @override
  String get completedEarlierTasksHeader => 'Natapos kanina';

  @override
  String get completedTasksHeader => 'Natapos';

  @override
  String get completedTodayTasksHeader => 'Natapos ngayon';

  @override
  String get completedYesterdayTasksHeader => 'Natapos kahapon';

  @override
  String get continueButton => 'Magpatuloy';

  @override
  String get customDate => 'Custom na date';

  @override
  String get delete => 'Tanggalin';

  @override
  String get deleteAllTasksDialogContent => 'Lahat ng task sa kategoryang ito ay matatanggal';

  @override
  String get deleteAllTasksDialogTitle => 'Tanggalin lahat ng mga task?';

  @override
  String deleteCategoryDialogContent(Object categoryName) {
    return 'Ang kategoryang ito ($categoryName) at lahat ng tasks nito ay matatanggal';
  }

  @override
  String get deleteCategoryDialogTitle => 'Tanggalin ang kategorya?';

  @override
  String get deleteCompletedTasksDialogContent => 'Lahat ng task na may markang tapos sa kategoryang ito ay matatanggal';

  @override
  String get deleteCompletedTasksDialogTitle => 'Tanggalin lahat ng natapos na mga task?';

  @override
  String get dueDate => 'Takdang Petsa';

  @override
  String get errorInformation => 'May nag-occur na issue!';

  @override
  String get finishButton => 'Tapos';

  @override
  String get greetings => 'Kumusta';

  @override
  String get hideCategoriesButton => 'Itago ang mga kategorya';

  @override
  String get later => 'Mamaya';

  @override
  String get license => 'Lisensya';

  @override
  String get newCategoryColorLabel => 'Kulay';

  @override
  String get newCategoryIconLabel => 'Icon';

  @override
  String get newCategoryLabel => 'Bagong Kategorya';

  @override
  String get newCategoryTasksInfo => 'Pwede kang magdagdag ng ilang task o gawin it pagtapos makagawa ng kategorya.';

  @override
  String get nextButton => 'Susunod';

  @override
  String get noCategoryHeader => 'Walang Kategorya';

  @override
  String get noDate => 'Walang Petsa';

  @override
  String get overdueTasksHeader => 'Overdue';

  @override
  String get reportIssuesButton => 'Magreport ng issues';

  @override
  String get saveButton => 'Isave';

  @override
  String get setDueDate => 'Magset ng takdang petsa';

  @override
  String get settings => 'Settings';

  @override
  String get settingsOptionDateFormat => 'Format ng Date';

  @override
  String get settingsOptionDisplayTimeCompleted => 'Ipakita ang petsa kung kailan natapos ang task';

  @override
  String get settingsOptionLanguage => 'Wika';

  @override
  String get settingsOptionThemeMode => 'Tema';

  @override
  String get settingsOptionTimeFormat => 'Format ng Oras';

  @override
  String get showCategoriesButton => 'Ipakita ang mga kategorya';

  @override
  String get showOptions => 'Ipakita ang mga option';

  @override
  String get sourceCode => 'Tignan ang source code';

  @override
  String get task => 'Task';

  @override
  String get taskOptionMoveToCategory => 'Pumunta sa kategorya';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeSystem => 'System';

  @override
  String get toDoTasksHeader => 'Gagawin';

  @override
  String get today => 'Ngayon';

  @override
  String get tomorrow => 'Bukas';

  @override
  String totalTasksInfo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Meron kang $count tasks na kailangang tapusin',
      one: 'Meron kang 1 task na kailangang tapusin',
      zero: 'Walang gagawin...Ayos!',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Kahapon';
}
