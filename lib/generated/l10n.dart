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
