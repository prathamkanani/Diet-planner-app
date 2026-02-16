// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `NutriPal`
  String get nutripal {
    return Intl.message('NutriPal', name: 'nutripal', desc: '', args: []);
  }

  /// `By continuing you agree to our`
  String get byContinuingYouAgreeToOur {
    return Intl.message(
      'By continuing you agree to our',
      name: 'byContinuingYouAgreeToOur',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Healthy eating made easy.`
  String get healthyEatingMadeEasy {
    return Intl.message(
      'Healthy eating made easy.',
      name: 'healthyEatingMadeEasy',
      desc: '',
      args: [],
    );
  }

  /// `First, what can we call you?`
  String get firstWhatCanWeCallYou {
    return Intl.message(
      'First, what can we call you?',
      name: 'firstWhatCanWeCallYou',
      desc: '',
      args: [],
    );
  }

  /// `We'd like to get to know you.`
  String get wedLikeToGetToKnowYou {
    return Intl.message(
      'We\'d like to get to know you.',
      name: 'wedLikeToGetToKnowYou',
      desc: '',
      args: [],
    );
  }

  /// `Preferred first name`
  String get preferredFirstName {
    return Intl.message(
      'Preferred first name',
      name: 'preferredFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Select all that apply.`
  String get selectAllThatApply {
    return Intl.message(
      'Select all that apply.',
      name: 'selectAllThatApply',
      desc: '',
      args: [],
    );
  }

  /// `Login Failed`
  String get loginFailed {
    return Intl.message(
      'Login Failed',
      name: 'loginFailed',
      desc: '',
      args: [],
    );
  }

  /// `We couldn’t sign you in. Please check your internet connection or try again.`
  String get weCouldntSignYouIn {
    return Intl.message(
      'We couldn’t sign you in. Please check your internet connection or try again.',
      name: 'weCouldntSignYouIn',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message('Dashboard', name: 'dashboard', desc: '', args: []);
  }

  /// `Report`
  String get report {
    return Intl.message('Report', name: 'report', desc: '', args: []);
  }

  /// `User Details`
  String get userDetails {
    return Intl.message(
      'User Details',
      name: 'userDetails',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, unable to log in. Please check your internet connection.`
  String get sorryUnableToLogIn {
    return Intl.message(
      'Sorry, unable to log in. Please check your internet connection.',
      name: 'sorryUnableToLogIn',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message('Try again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Please wait while we log you in...`
  String get pleaseWaitWhileWeLogYouIn {
    return Intl.message(
      'Please wait while we log you in...',
      name: 'pleaseWaitWhileWeLogYouIn',
      desc: '',
      args: [],
    );
  }

  /// `Oops, No data found!`
  String get oopsNoDataFound {
    return Intl.message(
      'Oops, No data found!',
      name: 'oopsNoDataFound',
      desc: '',
      args: [],
    );
  }

  /// `Get your Ideal body and healthier.`
  String get getYourIdealBodyAndHealthier {
    return Intl.message(
      'Get your Ideal body and healthier.',
      name: 'getYourIdealBodyAndHealthier',
      desc: '',
      args: [],
    );
  }

  /// `Make your diet more enjoyable and track your diet with NutriPal`
  String get makeYourDietMoreEnjoyableAndTrackYourDietWith {
    return Intl.message(
      'Make your diet more enjoyable and track your diet with NutriPal',
      name: 'makeYourDietMoreEnjoyableAndTrackYourDietWith',
      desc: '',
      args: [],
    );
  }

  /// `Try for free!`
  String get tryForFree {
    return Intl.message(
      'Try for free!',
      name: 'tryForFree',
      desc: '',
      args: [],
    );
  }

  /// `Forgot to log!`
  String get forgotToLog {
    return Intl.message(
      'Forgot to log!',
      name: 'forgotToLog',
      desc: '',
      args: [],
    );
  }

  /// `Logged!`
  String get logged {
    return Intl.message('Logged!', name: 'logged', desc: '', args: []);
  }

  /// `Sorry, cannot log past meals.`
  String get sorryCannotLogPastMeals {
    return Intl.message(
      'Sorry, cannot log past meals.',
      name: 'sorryCannotLogPastMeals',
      desc: '',
      args: [],
    );
  }

  /// `Already logged once. Cannot change or log again!`
  String get alreadyLoggedOnceCannotChangeOrLogAgain {
    return Intl.message(
      'Already logged once. Cannot change or log again!',
      name: 'alreadyLoggedOnceCannotChangeOrLogAgain',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message('Ok', name: 'ok', desc: '', args: []);
  }

  /// `Meal logged successfully!`
  String get mealLoggedSuccessfully {
    return Intl.message(
      'Meal logged successfully!',
      name: 'mealLoggedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to log!`
  String get failedToLog {
    return Intl.message(
      'Failed to log!',
      name: 'failedToLog',
      desc: '',
      args: [],
    );
  }

  /// `Log Meal!`
  String get logMeal {
    return Intl.message('Log Meal!', name: 'logMeal', desc: '', args: []);
  }

  /// `/${entity.targetCarbs} g`
  String get entitytargetcarbsG {
    return Intl.message(
      '/\${entity.targetCarbs} g',
      name: 'entitytargetcarbsG',
      desc: '',
      args: [],
    );
  }

  /// `Carbs`
  String get carbs {
    return Intl.message('Carbs', name: 'carbs', desc: '', args: []);
  }

  /// `/${entity.targetProtein} g`
  String get targetproteinG {
    return Intl.message(
      '/\${entity.targetProtein} g',
      name: 'targetproteinG',
      desc: '',
      args: [],
    );
  }

  /// `Protein`
  String get protein {
    return Intl.message('Protein', name: 'protein', desc: '', args: []);
  }

  /// `/${entity.targetFats} g`
  String get entitytargetfatsG {
    return Intl.message(
      '/\${entity.targetFats} g',
      name: 'entitytargetfatsG',
      desc: '',
      args: [],
    );
  }

  /// `Fat`
  String get fat {
    return Intl.message('Fat', name: 'fat', desc: '', args: []);
  }

  /// `kcal left`
  String get kcalLeft {
    return Intl.message('kcal left', name: 'kcalLeft', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Sign in to securely save your data, personalize your experience, and track your progress`
  String get signInToSecurelySaveYourData {
    return Intl.message(
      'Sign in to securely save your data, personalize your experience, and track your progress',
      name: 'signInToSecurelySaveYourData',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `What is your baseline activity level?`
  String get whatIsYourBaselineActivityLevel {
    return Intl.message(
      'What is your baseline activity level?',
      name: 'whatIsYourBaselineActivityLevel',
      desc: '',
      args: [],
    );
  }

  /// `Choose what describes you best:`
  String get chooseWhatDescribesYouBest {
    return Intl.message(
      'Choose what describes you best:',
      name: 'chooseWhatDescribesYouBest',
      desc: '',
      args: [],
    );
  }

  /// `Not Very Active`
  String get notVeryActive {
    return Intl.message(
      'Not Very Active',
      name: 'notVeryActive',
      desc: '',
      args: [],
    );
  }

  /// `Lightly Active`
  String get lightlyActive {
    return Intl.message(
      'Lightly Active',
      name: 'lightlyActive',
      desc: '',
      args: [],
    );
  }

  /// `Very Active`
  String get veryActive {
    return Intl.message('Very Active', name: 'veryActive', desc: '', args: []);
  }

  /// `Spend most of the day sitting (e.g., desk job).`
  String get spendMostOfTheDaySittingEgDeskJob {
    return Intl.message(
      'Spend most of the day sitting (e.g., desk job).',
      name: 'spendMostOfTheDaySittingEgDeskJob',
      desc: '',
      args: [],
    );
  }

  /// `Spend a good part of the day doing heavy physical activity (e.g., bike messenger, carpenter).`
  String get spendAGoodPartOfTheDayDoingHeavyPhysical {
    return Intl.message(
      'Spend a good part of the day doing heavy physical activity (e.g., bike messenger, carpenter).',
      name: 'spendAGoodPartOfTheDayDoingHeavyPhysical',
      desc: '',
      args: [],
    );
  }

  /// `Spend a good part of the day on your feet (e.g., teacher, salesperson).`
  String get spendAGoodPartOfTheDayOnYourFeet {
    return Intl.message(
      'Spend a good part of the day on your feet (e.g., teacher, salesperson).',
      name: 'spendAGoodPartOfTheDayOnYourFeet',
      desc: '',
      args: [],
    );
  }

  /// `Which health habits are most important to you?`
  String get whichHealthHabitsAreMostImportantToYou {
    return Intl.message(
      'Which health habits are most important to you?',
      name: 'whichHealthHabitsAreMostImportantToYou',
      desc: '',
      args: [],
    );
  }

  /// `Recommended health habits`
  String get recommendedHealthHabits {
    return Intl.message(
      'Recommended health habits',
      name: 'recommendedHealthHabits',
      desc: '',
      args: [],
    );
  }

  /// `How often do you plan your meals in advance?`
  String get howOftenDoYouPlanYourMealsInAdvance {
    return Intl.message(
      'How often do you plan your meals in advance?',
      name: 'howOftenDoYouPlanYourMealsInAdvance',
      desc: '',
      args: [],
    );
  }

  /// `Just a few more questions`
  String get justAFewMoreQuestions {
    return Intl.message(
      'Just a few more questions',
      name: 'justAFewMoreQuestions',
      desc: '',
      args: [],
    );
  }

  /// `How tall are you? (in cm)`
  String get howTallAreYouInCm {
    return Intl.message(
      'How tall are you? (in cm)',
      name: 'howTallAreYouInCm',
      desc: '',
      args: [],
    );
  }

  /// `How much do you weigh? (in kg)`
  String get howMuchDoYouWeighInKg {
    return Intl.message(
      'How much do you weigh? (in kg)',
      name: 'howMuchDoYouWeighInKg',
      desc: '',
      args: [],
    );
  }

  /// `Tell us a little bit about yourself`
  String get tellUsALittleBitAboutYourself {
    return Intl.message(
      'Tell us a little bit about yourself',
      name: 'tellUsALittleBitAboutYourself',
      desc: '',
      args: [],
    );
  }

  /// `Please select a gender`
  String get pleaseSelectAGender {
    return Intl.message(
      'Please select a gender',
      name: 'pleaseSelectAGender',
      desc: '',
      args: [],
    );
  }

  /// `How old are you?`
  String get howOldAreYou {
    return Intl.message(
      'How old are you?',
      name: 'howOldAreYou',
      desc: '',
      args: [],
    );
  }

  /// `Where do you live? (country)`
  String get whereDoYouLiveCountry {
    return Intl.message(
      'Where do you live? (country)',
      name: 'whereDoYouLiveCountry',
      desc: '',
      args: [],
    );
  }

  /// `Go back`
  String get goBack {
    return Intl.message('Go back', name: 'goBack', desc: '', args: []);
  }

  /// `Welcome, Health Explorer`
  String get welcomeHealthExplorer {
    return Intl.message(
      'Welcome, Health Explorer',
      name: 'welcomeHealthExplorer',
      desc: '',
      args: [],
    );
  }

  /// `I am NutriPal.`
  String get iAmNutripal {
    return Intl.message(
      'I am NutriPal.',
      name: 'iAmNutripal',
      desc: '',
      args: [],
    );
  }

  /// `Your health's new best friend.`
  String get yourHealthsNewBestFriend {
    return Intl.message(
      'Your health\'s new best friend.',
      name: 'yourHealthsNewBestFriend',
      desc: '',
      args: [],
    );
  }

  /// `Make daily meal logs!`
  String get makeDailyMealLogs {
    return Intl.message(
      'Make daily meal logs!',
      name: 'makeDailyMealLogs',
      desc: '',
      args: [],
    );
  }

  /// `Log meals, understand your intake, and build healthier habits—one day at a time.`
  String get logMealsUnderstandYourIntakeAndBuildHealthierHabitsoneDay {
    return Intl.message(
      'Log meals, understand your intake, and build healthier habits—one day at a time.',
      name: 'logMealsUnderstandYourIntakeAndBuildHealthierHabitsoneDay',
      desc: '',
      args: [],
    );
  }

  /// `Get regular calorie tracking!`
  String get getRegularCalorieTracking {
    return Intl.message(
      'Get regular calorie tracking!',
      name: 'getRegularCalorieTracking',
      desc: '',
      args: [],
    );
  }

  /// `Easily track calories, monitor nutrition, and stay aligned with your health goals.`
  String get easilyTrackCaloriesMonitorNutritionAndStayAlignedWithYour {
    return Intl.message(
      'Easily track calories, monitor nutrition, and stay aligned with your health goals.',
      name: 'easilyTrackCaloriesMonitorNutritionAndStayAlignedWithYour',
      desc: '',
      args: [],
    );
  }

  /// `Wait while the meal plan is generated...`
  String get waitWhileTheMealPlanIsGenerated {
    return Intl.message(
      'Wait while the meal plan is generated...',
      name: 'waitWhileTheMealPlanIsGenerated',
      desc: '',
      args: [],
    );
  }

  /// `User Profile`
  String get userProfile {
    return Intl.message(
      'User Profile',
      name: 'userProfile',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Enter your full name`
  String get enterYourFullName {
    return Intl.message(
      'Enter your full name',
      name: 'enterYourFullName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Enter your email`
  String get enterYourEmail {
    return Intl.message(
      'Enter your email',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Mobile number`
  String get mobileNumber {
    return Intl.message(
      'Mobile number',
      name: 'mobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Mobile Number`
  String get enterYourMobileNumber {
    return Intl.message(
      'Enter your Mobile Number',
      name: 'enterYourMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message('Age', name: 'age', desc: '', args: []);
  }

  /// `Enter your age`
  String get enterYourAge {
    return Intl.message(
      'Enter your age',
      name: 'enterYourAge',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Enter your gender`
  String get enterYourGender {
    return Intl.message(
      'Enter your gender',
      name: 'enterYourGender',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message('Height', name: 'height', desc: '', args: []);
  }

  /// `Enter your height`
  String get enterYourHeight {
    return Intl.message(
      'Enter your height',
      name: 'enterYourHeight',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message('Weight', name: 'weight', desc: '', args: []);
  }

  /// `Enter your weight`
  String get enterYourWeight {
    return Intl.message(
      'Enter your weight',
      name: 'enterYourWeight',
      desc: '',
      args: [],
    );
  }

  /// `Save Profile`
  String get saveProfile {
    return Intl.message(
      'Save Profile',
      name: 'saveProfile',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
