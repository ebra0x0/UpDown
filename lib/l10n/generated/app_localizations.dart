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

  /// No description provided for @elevator_status_working.
  ///
  /// In en, this message translates to:
  /// **'Working'**
  String get elevator_status_working;

  /// No description provided for @elevator_status_broken.
  ///
  /// In en, this message translates to:
  /// **'Broken'**
  String get elevator_status_broken;

  /// No description provided for @elevator_status_repair.
  ///
  /// In en, this message translates to:
  /// **'Under Repair'**
  String get elevator_status_repair;

  /// No description provided for @elevator_status_maintenance.
  ///
  /// In en, this message translates to:
  /// **'Under Maintenance'**
  String get elevator_status_maintenance;

  /// No description provided for @elevator_status_disabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get elevator_status_disabled;

  /// No description provided for @elevator_description_Working.
  ///
  /// In en, this message translates to:
  /// **'The elevator\'s working'**
  String get elevator_description_Working;

  /// No description provided for @elevator_description_Broken.
  ///
  /// In en, this message translates to:
  /// **'The elevator\'s broken and cannot be used'**
  String get elevator_description_Broken;

  /// No description provided for @elevator_description_Repair.
  ///
  /// In en, this message translates to:
  /// **'The elevator\'s under repair'**
  String get elevator_description_Repair;

  /// No description provided for @elevator_description_Maintenance.
  ///
  /// In en, this message translates to:
  /// **'The elevator\'s under maintenance'**
  String get elevator_description_Maintenance;

  /// No description provided for @elevator_description_Disabled.
  ///
  /// In en, this message translates to:
  /// **'The elevator\'s currently unavailable'**
  String get elevator_description_Disabled;

  /// No description provided for @issue_type_door_not_opening.
  ///
  /// In en, this message translates to:
  /// **'Door Not Opening'**
  String get issue_type_door_not_opening;

  /// No description provided for @issue_type_stuck_between_floors.
  ///
  /// In en, this message translates to:
  /// **'Stuck Between Floors'**
  String get issue_type_stuck_between_floors;

  /// No description provided for @issue_type_noise.
  ///
  /// In en, this message translates to:
  /// **'Noise'**
  String get issue_type_noise;

  /// No description provided for @issue_type_not_responding.
  ///
  /// In en, this message translates to:
  /// **'Not Responding'**
  String get issue_type_not_responding;

  /// No description provided for @issue_type_button_not_responding.
  ///
  /// In en, this message translates to:
  /// **'Button Not Responding'**
  String get issue_type_button_not_responding;

  /// No description provided for @issue_type_above_floor.
  ///
  /// In en, this message translates to:
  /// **'Above Floor'**
  String get issue_type_above_floor;

  /// No description provided for @issue_type_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get issue_type_other;

  /// No description provided for @issue_type_priority_DoorNotOpening.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get issue_type_priority_DoorNotOpening;

  /// No description provided for @issue_type_priority_StuckBetweenFloors.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get issue_type_priority_StuckBetweenFloors;

  /// No description provided for @issue_type_priority_Noise.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get issue_type_priority_Noise;

  /// No description provided for @issue_type_priority_NotResponding.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get issue_type_priority_NotResponding;

  /// No description provided for @issue_type_priority_ButtonNotResponding.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get issue_type_priority_ButtonNotResponding;

  /// No description provided for @issue_type_priority_AboveFloor.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get issue_type_priority_AboveFloor;

  /// No description provided for @issue_type_priority_Other.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get issue_type_priority_Other;

  /// No description provided for @issue_status_not_fixed.
  ///
  /// In en, this message translates to:
  /// **'Not Fixed'**
  String get issue_status_not_fixed;

  /// No description provided for @issue_status_needs_parts.
  ///
  /// In en, this message translates to:
  /// **'Needs Parts'**
  String get issue_status_needs_parts;

  /// No description provided for @issue_status_escalated.
  ///
  /// In en, this message translates to:
  /// **'Escalated'**
  String get issue_status_escalated;

  /// No description provided for @issue_status_fixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get issue_status_fixed;

  /// No description provided for @issue_description_NotFixed.
  ///
  /// In en, this message translates to:
  /// **'The issue has not been fixed yet'**
  String get issue_description_NotFixed;

  /// No description provided for @issue_description_NeedsParts.
  ///
  /// In en, this message translates to:
  /// **'The issue needs parts'**
  String get issue_description_NeedsParts;

  /// No description provided for @issue_description_Escalated.
  ///
  /// In en, this message translates to:
  /// **'The issue has been escalated to another technecian'**
  String get issue_description_Escalated;

  /// No description provided for @issue_description_Fixed.
  ///
  /// In en, this message translates to:
  /// **'The issue has been fixed'**
  String get issue_description_Fixed;

  /// No description provided for @report_status_pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get report_status_pending;

  /// No description provided for @report_status_reported.
  ///
  /// In en, this message translates to:
  /// **'Reported'**
  String get report_status_reported;

  /// No description provided for @report_status_coming.
  ///
  /// In en, this message translates to:
  /// **'Coming'**
  String get report_status_coming;

  /// No description provided for @report_status_arrived.
  ///
  /// In en, this message translates to:
  /// **'Arrived'**
  String get report_status_arrived;

  /// No description provided for @report_status_in_progress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get report_status_in_progress;

  /// No description provided for @report_status_resolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get report_status_resolved;

  /// No description provided for @report_description_Pending.
  ///
  /// In en, this message translates to:
  /// **'The report is pending and hasn\'t been handled yet'**
  String get report_description_Pending;

  /// No description provided for @report_description_Reported.
  ///
  /// In en, this message translates to:
  /// **'The issue has been reported'**
  String get report_description_Reported;

  /// No description provided for @report_description_Coming.
  ///
  /// In en, this message translates to:
  /// **'The technecian\'s on the way'**
  String get report_description_Coming;

  /// No description provided for @report_description_Arrived.
  ///
  /// In en, this message translates to:
  /// **'The technician has arrived'**
  String get report_description_Arrived;

  /// No description provided for @report_description_InProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get report_description_InProgress;

  /// No description provided for @report_description_Resolved.
  ///
  /// In en, this message translates to:
  /// **'The issue has been resolved'**
  String get report_description_Resolved;

  /// No description provided for @unit_name_engine.
  ///
  /// In en, this message translates to:
  /// **'Engine'**
  String get unit_name_engine;

  /// No description provided for @unit_name_cabin.
  ///
  /// In en, this message translates to:
  /// **'Cabin'**
  String get unit_name_cabin;

  /// No description provided for @unit_name_counter.
  ///
  /// In en, this message translates to:
  /// **'Counter'**
  String get unit_name_counter;

  /// No description provided for @unit_name_wires.
  ///
  /// In en, this message translates to:
  /// **'Wires'**
  String get unit_name_wires;

  /// No description provided for @unit_name_control.
  ///
  /// In en, this message translates to:
  /// **'Control control'**
  String get unit_name_control;

  /// No description provided for @unit_status_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get unit_status_active;

  /// No description provided for @unit_status_maintenance.
  ///
  /// In en, this message translates to:
  /// **'Needs Maintenance'**
  String get unit_status_maintenance;

  /// No description provided for @unit_status_out_of_service.
  ///
  /// In en, this message translates to:
  /// **'Out Of Service'**
  String get unit_status_out_of_service;

  /// No description provided for @unit_status_requires_replacement.
  ///
  /// In en, this message translates to:
  /// **'Requires Replacement'**
  String get unit_status_requires_replacement;

  /// No description provided for @floor_status_accessible.
  ///
  /// In en, this message translates to:
  /// **'Accessible'**
  String get floor_status_accessible;

  /// No description provided for @floor_status_out_of_service.
  ///
  /// In en, this message translates to:
  /// **'Out Of Service'**
  String get floor_status_out_of_service;

  /// No description provided for @floor_status_closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get floor_status_closed;

  /// No description provided for @floor_status_restricted.
  ///
  /// In en, this message translates to:
  /// **'Restricted'**
  String get floor_status_restricted;

  /// No description provided for @part_type_door_lock.
  ///
  /// In en, this message translates to:
  /// **'Lock'**
  String get part_type_door_lock;

  /// No description provided for @part_type_door_pump.
  ///
  /// In en, this message translates to:
  /// **'Pumb'**
  String get part_type_door_pump;

  /// No description provided for @part_type_door_spring.
  ///
  /// In en, this message translates to:
  /// **'Spring'**
  String get part_type_door_spring;

  /// No description provided for @part_condition_good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get part_condition_good;

  /// No description provided for @part_condition_worn.
  ///
  /// In en, this message translates to:
  /// **'Worn'**
  String get part_condition_worn;

  /// No description provided for @part_condition_broken.
  ///
  /// In en, this message translates to:
  /// **'Broken'**
  String get part_condition_broken;
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
