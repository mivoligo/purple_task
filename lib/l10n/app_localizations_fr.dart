// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get aboutAppViewTitle => 'À propos de Purple Task';

  @override
  String get addCategoryButton => 'Ajouter une catégorie';

  @override
  String get addNewTaskInputPlaceholder => 'Ajouter une tâche';

  @override
  String get allTasksHeader => 'Tout';

  @override
  String get appDescription => 'Une application TO-DO simple pour vous aider à compléter vos tâches';

  @override
  String get cancelButton => 'Annuler';

  @override
  String get category => 'Catégorie';

  @override
  String get categoryNameLabel => 'Nom';

  @override
  String get categoryOptionChangeColor => 'Modifier la couleur';

  @override
  String get categoryOptionChangeIcon => 'Modifier l\'icône';

  @override
  String get categoryOptionChangeName => 'Modifier le nom';

  @override
  String get categoryOptionDeleteAllTasks => 'Supprimer toutes les tâches';

  @override
  String get categoryOptionDeleteCategory => 'Supprimer la catégorie';

  @override
  String categoryTasksInfo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tâches restantes',
      one: '1 tâche restante',
      zero: 'Aucune tâche restante',
    );
    return '$_temp0';
  }

  @override
  String get categoryOptionDeleteCompleted => 'Supprimer les tâches complétées';

  @override
  String get changeCategoryColorDialogTitle => 'Modifier la couleur de la catégorie';

  @override
  String get changeCategoryIconDialogTitle => 'Modifier l\'icône de la catégorie';

  @override
  String get changeCategoryNameDialogTitle => 'Modifier le nom de la catégorie';

  @override
  String get changeTaskName => 'Modifier la tâche';

  @override
  String get closeButton => 'Fermer';

  @override
  String get completedEarlierTasksHeader => 'Complété plus tôt';

  @override
  String get completedTasksHeader => 'Complété';

  @override
  String get completedTodayTasksHeader => 'Complété aujourd\'hui';

  @override
  String get completedYesterdayTasksHeader => 'Complété hier';

  @override
  String get continueButton => 'Continuer';

  @override
  String get customDate => 'Saisie manuelle';

  @override
  String get delete => 'Supprimer';

  @override
  String get deleteAllTasksDialogContent => 'Toutes les tâches dans cette catégorie seront supprimés.';

  @override
  String get deleteAllTasksDialogTitle => 'Supprimer toutes les tâches?';

  @override
  String deleteCategoryDialogContent(Object categoryName) {
    return 'Cette catégorie ($categoryName) et toutes ses tâches seront supprimés.';
  }

  @override
  String get deleteCategoryDialogTitle => 'Supprimer la catégorie?';

  @override
  String get deleteCompletedTasksDialogContent => 'Toutes les taches complétées dans cette catégorie seront supprimés.';

  @override
  String get deleteCompletedTasksDialogTitle => 'Supprimer les tâches complétées?';

  @override
  String get dueDate => 'Date limite';

  @override
  String get errorInformation => 'Un problème est survenu!';

  @override
  String get finishButton => 'Finir';

  @override
  String get greetings => 'Bonjour';

  @override
  String get hideCategoriesButton => 'Retour';

  @override
  String get later => 'Plus tard';

  @override
  String get license => 'License';

  @override
  String get newCategoryColorLabel => 'Couleur';

  @override
  String get newCategoryIconLabel => 'Icône';

  @override
  String get newCategoryLabel => 'Nouvelle catégorie';

  @override
  String get newCategoryTasksInfo => 'Vous pouvez ajouter des tâches maintenant ou le faire après avoir créé la catégorie.';

  @override
  String get nextButton => 'Suivant';

  @override
  String get noCategoryHeader => 'Sans catégorie';

  @override
  String get noDate => 'Pas de date limite';

  @override
  String get overdueTasksHeader => 'En retard';

  @override
  String get reportIssuesButton => 'Signaler un problème';

  @override
  String get saveButton => 'Sauvegarder';

  @override
  String get setDueDate => 'Modifier la date limite';

  @override
  String get settings => 'Paramètres';

  @override
  String get settingsOptionDateFormat => 'Format des dates';

  @override
  String get settingsOptionDisplayTimeCompleted => 'Montrer l\'horaire de complétion des tâches';

  @override
  String get settingsOptionLanguage => 'Langue';

  @override
  String get settingsOptionThemeMode => 'Apparence';

  @override
  String get settingsOptionTimeFormat => 'Format horaire';

  @override
  String get showCategoriesButton => 'Voir les catégories';

  @override
  String get showOptions => 'Voir les options';

  @override
  String get sourceCode => 'Voir le code source';

  @override
  String get task => 'Tâche';

  @override
  String get taskOptionMoveToCategory => 'Modifier la catégorie';

  @override
  String get themeModeDark => 'Sombre';

  @override
  String get themeModeLight => 'Clair';

  @override
  String get themeModeSystem => 'Système';

  @override
  String get toDoTasksHeader => 'À faire';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get tomorrow => 'Demain';

  @override
  String totalTasksInfo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vous avez $count tâches à compléter',
      one: 'Vous avez 1 tâche à compléter',
      zero: 'Vous n\'avez rien à faire... Super!',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Hier';
}
