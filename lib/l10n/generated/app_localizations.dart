import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @elevator_working.
  ///
  /// In en, this message translates to:
  /// **'Working'**
  String get elevator_working;

  /// No description provided for @elevator_broken.
  ///
  /// In en, this message translates to:
  /// **'Broken'**
  String get elevator_broken;

  /// No description provided for @elevator_repair.
  ///
  /// In en, this message translates to:
  /// **'Under Repair'**
  String get elevator_repair;

  /// No description provided for @elevator_maintenance.
  ///
  /// In en, this message translates to:
  /// **'Under Maintenance'**
  String get elevator_maintenance;

  /// No description provided for @elevator_disabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get elevator_disabled;

  /// No description provided for @elevatorWorkingDescription.
  ///
  /// In en, this message translates to:
  /// **'The elevator\'s working'**
  String get elevatorWorkingDescription;

  /// No description provided for @elevatorBrokenDescription.
  ///
  /// In en, this message translates to:
  /// **'The elevator\'s broken and cannot be used'**
  String get elevatorBrokenDescription;

  /// No description provided for @elevatorRepairDescription.
  ///
  /// In en, this message translates to:
  /// **'The elevator\'s under repair'**
  String get elevatorRepairDescription;

  /// No description provided for @elevatorMaintenanceDescription.
  ///
  /// In en, this message translates to:
  /// **'The elevator\'s under maintenance'**
  String get elevatorMaintenanceDescription;

  /// No description provided for @elevatorDisabledDescription.
  ///
  /// In en, this message translates to:
  /// **'The elevator\'s currently unavailable'**
  String get elevatorDisabledDescription;

  /// No description provided for @issueType_door_not_opening.
  ///
  /// In en, this message translates to:
  /// **'Door Not Opening'**
  String get issueType_door_not_opening;

  /// No description provided for @issueType_stuck_between_floors.
  ///
  /// In en, this message translates to:
  /// **'Stuck Between Floors'**
  String get issueType_stuck_between_floors;

  /// No description provided for @issueType_noise.
  ///
  /// In en, this message translates to:
  /// **'Noise'**
  String get issueType_noise;

  /// No description provided for @issueType_not_responding.
  ///
  /// In en, this message translates to:
  /// **'Not Responding'**
  String get issueType_not_responding;

  /// No description provided for @issueType_button_not_responding.
  ///
  /// In en, this message translates to:
  /// **'Button Not Responding'**
  String get issueType_button_not_responding;

  /// No description provided for @issueType_above_floor.
  ///
  /// In en, this message translates to:
  /// **'Above Floor'**
  String get issueType_above_floor;

  /// No description provided for @issueType_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get issueType_other;

  /// No description provided for @issue_not_fixed.
  ///
  /// In en, this message translates to:
  /// **'Not Fixed'**
  String get issue_not_fixed;

  /// No description provided for @issue_needs_parts.
  ///
  /// In en, this message translates to:
  /// **'Needs Parts'**
  String get issue_needs_parts;

  /// No description provided for @issue_escalated.
  ///
  /// In en, this message translates to:
  /// **'Escalated'**
  String get issue_escalated;

  /// No description provided for @issue_fixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get issue_fixed;

  /// No description provided for @notFixedDescription.
  ///
  /// In en, this message translates to:
  /// **'The issue has not been fixed yet'**
  String get notFixedDescription;

  /// No description provided for @needsPartsDescription.
  ///
  /// In en, this message translates to:
  /// **'The issue needs parts'**
  String get needsPartsDescription;

  /// No description provided for @escalatedDescription.
  ///
  /// In en, this message translates to:
  /// **'The issue has been escalated to another technecian'**
  String get escalatedDescription;

  /// No description provided for @fixedDescription.
  ///
  /// In en, this message translates to:
  /// **'The issue has been fixed'**
  String get fixedDescription;

  /// No description provided for @report_pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get report_pending;

  /// No description provided for @report_reported.
  ///
  /// In en, this message translates to:
  /// **'Reported'**
  String get report_reported;

  /// No description provided for @report_coming.
  ///
  /// In en, this message translates to:
  /// **'Coming'**
  String get report_coming;

  /// No description provided for @report_arrived.
  ///
  /// In en, this message translates to:
  /// **'Arrived'**
  String get report_arrived;

  /// No description provided for @report_in_progress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get report_in_progress;

  /// No description provided for @report_resolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get report_resolved;

  /// No description provided for @reportPendingDescription.
  ///
  /// In en, this message translates to:
  /// **'The report is pending and hasn\'t been handled yet'**
  String get reportPendingDescription;

  /// No description provided for @reportReportedDescription.
  ///
  /// In en, this message translates to:
  /// **'The issue has been reported'**
  String get reportReportedDescription;

  /// No description provided for @reportComingDescription.
  ///
  /// In en, this message translates to:
  /// **'The technecian\'s on the way'**
  String get reportComingDescription;

  /// No description provided for @reportArrivedDescription.
  ///
  /// In en, this message translates to:
  /// **'The technician has arrived'**
  String get reportArrivedDescription;

  /// No description provided for @reportInProgressDescription.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get reportInProgressDescription;

  /// No description provided for @reportResolvedDescription.
  ///
  /// In en, this message translates to:
  /// **'The issue has been resolved'**
  String get reportResolvedDescription;

  /// No description provided for @unit_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get unit_active;

  /// No description provided for @unit_needs_maintenance.
  ///
  /// In en, this message translates to:
  /// **'Needs Maintenance'**
  String get unit_needs_maintenance;

  /// No description provided for @unit_out_of_service.
  ///
  /// In en, this message translates to:
  /// **'Out Of Service'**
  String get unit_out_of_service;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
