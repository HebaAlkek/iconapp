import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:icon/LanguageChangeProvider.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/screen/auth_screen.dart';
import 'package:icon/screen/home_page.dart';
import 'package:icon/screen/login_screen.dart';
import 'package:icon/screen/splashActivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';
Future<void> main() async {

  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyApp createState() => new _MyApp();
  static _MyApp? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyApp>();
}

class _MyApp extends State<MyApp> {



  Rx<Locale>? _locale =Locale.fromSubtags(languageCode: 'en').obs;

  void setLocale(Locale value) {
    _locale!.value = value;
  }

  String? lang;

  getlang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lang = prefs.getString('lang');
    if (lang == null) {
      setLocale(Locale.fromSubtags(languageCode: 'en'));
    } else {
      setLocale(Locale.fromSubtags(languageCode: lang!));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getlang();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageChangeProvider>(
      create: (context) => LanguageChangeProvider(),
      child: Builder(
          builder: (context) => Obx(() =>GetMaterialApp(
      debugShowCheckedModeBanner: false,

            locale: _locale!.value,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
      title: 'iCON POS',
      home: Splash(),
    ))));
  }
}
