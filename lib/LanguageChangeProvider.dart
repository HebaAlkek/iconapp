import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeProvider with ChangeNotifier{

  Locale _currentLocale = new Locale("en");

  String? lang;
   Locale  currentLocale = new Locale("en");

void getLang() async {

    SharedPreferences prefs = await SharedPreferences
        .getInstance();
    lang = prefs.getString('lang');
    if(lang==null){
      LanguageChangeProvider().changeLocale("en");
      _currentLocale = new Locale("en");
      currentLocale=_currentLocale;
    }else{
      LanguageChangeProvider().changeLocale(lang!);
      _currentLocale = new Locale(lang!);
      currentLocale=_currentLocale;

    }
  }


  void changeLocale(String _locale){
    this._currentLocale = new Locale(_locale);
    notifyListeners();
  }

}