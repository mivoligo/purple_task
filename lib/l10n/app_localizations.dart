import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fil.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('da'),
    Locale('de'),
    Locale('fil'),
    Locale('fr'),
    Locale('pl')
  ];

  /// No description provided for @aboutAppViewTitle.
  ///
  /// In en, this message translates to:
  /// **'About Purple Task'**
  String get aboutAppViewTitle;

  /// No description provided for @addCategoryButton.
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get addCategoryButton;

  /// No description provided for @addNewTaskInputPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Add new task'**
  String get addNewTaskInputPlaceholder;

  /// No description provided for @allTasksHeader.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allTasksHeader;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'Simple TO-DO app to help you get stuff done'**
  String get appDescription;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @categoryNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get categoryNameLabel;

  /// No description provided for @categoryOptionChangeColor.
  ///
  /// In en, this message translates to:
  /// **'Change color'**
  String get categoryOptionChangeColor;

  /// No description provided for @categoryOptionChangeIcon.
  ///
  /// In en, this message translates to:
  /// **'Change icon'**
  String get categoryOptionChangeIcon;

  /// No description provided for @categoryOptionChangeName.
  ///
  /// In en, this message translates to:
  /// **'Change name'**
  String get categoryOptionChangeName;

  /// No description provided for @categoryOptionDeleteAllTasks.
  ///
  /// In en, this message translates to:
  /// **'Delete all tasks'**
  String get categoryOptionDeleteAllTasks;

  /// No description provided for @categoryOptionDeleteCategory.
  ///
  /// In en, this message translates to:
  /// **'Delete category'**
  String get categoryOptionDeleteCategory;

  /// No description provided for @categoryTasksInfo.
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =0{No tasks left} =1{1 task left} other{{count} tasks left}}'**
  String categoryTasksInfo(num count);

  /// No description provided for @categoryOptionDeleteCompleted.
  ///
  /// In en, this message translates to:
  /// **'Delete completed tasks'**
  String get categoryOptionDeleteCompleted;

  /// No description provided for @changeCategoryColorDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Change color of category'**
  String get changeCategoryColorDialogTitle;

  /// No description provided for @changeCategoryIconDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Change icon of category'**
  String get changeCategoryIconDialogTitle;

  /// No description provided for @changeCategoryNameDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Change name of category'**
  String get changeCategoryNameDialogTitle;

  /// No description provided for @changeTaskName.
  ///
  /// In en, this message translates to:
  /// **'Change name of task'**
  String get changeTaskName;

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// No description provided for @completedEarlierTasksHeader.
  ///
  /// In en, this message translates to:
  /// **'Completed earlier'**
  String get completedEarlierTasksHeader;

  /// No description provided for @completedTasksHeader.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedTasksHeader;

  /// No description provided for @completedTodayTasksHeader.
  ///
  /// In en, this message translates to:
  /// **'Completed today'**
  String get completedTodayTasksHeader;

  /// No description provided for @completedYesterdayTasksHeader.
  ///
  /// In en, this message translates to:
  /// **'Completed yesterday'**
  String get completedYesterdayTasksHeader;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @customDate.
  ///
  /// In en, this message translates to:
  /// **'Custom date'**
  String get customDate;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteAllTasksDialogContent.
  ///
  /// In en, this message translates to:
  /// **'All tasks in this category will be deleted'**
  String get deleteAllTasksDialogContent;

  /// No description provided for @deleteAllTasksDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all tasks?'**
  String get deleteAllTasksDialogTitle;

  /// No description provided for @deleteCategoryDialogContent.
  ///
  /// In en, this message translates to:
  /// **'This category ({categoryName}) and all tasks in it will be deleted'**
  String deleteCategoryDialogContent(Object categoryName);

  /// No description provided for @deleteCategoryDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete category?'**
  String get deleteCategoryDialogTitle;

  /// No description provided for @deleteCompletedTasksDialogContent.
  ///
  /// In en, this message translates to:
  /// **'All tasks marked as completed in this category will be deleted'**
  String get deleteCompletedTasksDialogContent;

  /// No description provided for @deleteCompletedTasksDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete completed tasks?'**
  String get deleteCompletedTasksDialogTitle;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get dueDate;

  /// No description provided for @errorInformation.
  ///
  /// In en, this message translates to:
  /// **'An issue occurred!'**
  String get errorInformation;

  /// No description provided for @finishButton.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finishButton;

  /// No description provided for @greetings.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get greetings;

  /// No description provided for @hideCategoriesButton.
  ///
  /// In en, this message translates to:
  /// **'Hide categories'**
  String get hideCategoriesButton;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @license.
  ///
  /// In en, this message translates to:
  /// **'License'**
  String get license;

  /// No description provided for @newCategoryColorLabel.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get newCategoryColorLabel;

  /// No description provided for @newCategoryIconLabel.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get newCategoryIconLabel;

  /// No description provided for @newCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'New Category'**
  String get newCategoryLabel;

  /// No description provided for @newCategoryTasksInfo.
  ///
  /// In en, this message translates to:
  /// **'You can add few tasks now or do it after finishing category creation.'**
  String get newCategoryTasksInfo;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @noCategoryHeader.
  ///
  /// In en, this message translates to:
  /// **'Uncategorized'**
  String get noCategoryHeader;

  /// No description provided for @noDate.
  ///
  /// In en, this message translates to:
  /// **'No date'**
  String get noDate;

  /// No description provided for @overdueTasksHeader.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdueTasksHeader;

  /// No description provided for @reportIssuesButton.
  ///
  /// In en, this message translates to:
  /// **'Report issues'**
  String get reportIssuesButton;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @setDueDate.
  ///
  /// In en, this message translates to:
  /// **'Set due date'**
  String get setDueDate;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsOptionDateFormat.
  ///
  /// In en, this message translates to:
  /// **'Date format'**
  String get settingsOptionDateFormat;

  /// No description provided for @settingsOptionDisplayTimeCompleted.
  ///
  /// In en, this message translates to:
  /// **'Display task\'s completion time'**
  String get settingsOptionDisplayTimeCompleted;

  /// No description provided for @settingsOptionLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsOptionLanguage;

  /// No description provided for @settingsOptionThemeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsOptionThemeMode;

  /// No description provided for @settingsOptionTimeFormat.
  ///
  /// In en, this message translates to:
  /// **'Time format'**
  String get settingsOptionTimeFormat;

  /// No description provided for @showCategoriesButton.
  ///
  /// In en, this message translates to:
  /// **'Show categories'**
  String get showCategoriesButton;

  /// No description provided for @showOptions.
  ///
  /// In en, this message translates to:
  /// **'Show options'**
  String get showOptions;

  /// No description provided for @sourceCode.
  ///
  /// In en, this message translates to:
  /// **'View source code'**
  String get sourceCode;

  /// No description provided for @task.
  ///
  /// In en, this message translates to:
  /// **'Task'**
  String get task;

  /// No description provided for @taskOptionMoveToCategory.
  ///
  /// In en, this message translates to:
  /// **'Move to category'**
  String get taskOptionMoveToCategory;

  /// No description provided for @themeModeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeModeDark;

  /// No description provided for @themeModeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeModeLight;

  /// No description provided for @themeModeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeModeSystem;

  /// No description provided for @toDoTasksHeader.
  ///
  /// In en, this message translates to:
  /// **'To Do'**
  String get toDoTasksHeader;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @totalTasksInfo.
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =0{Nothing to do...Great!} =1{You have 1 task to complete} other{You have {count} tasks to complete}}'**
  String totalTasksInfo(num count);

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['da', 'de', 'en', 'fil', 'fr', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'da': return AppLocalizationsDa();
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'fil': return AppLocalizationsFil();
    case 'fr': return AppLocalizationsFr();
    case 'pl': return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
