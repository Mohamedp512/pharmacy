import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String getTranslated(BuildContext context,String key){
  return AppLocale.of(context).getTranslated(key);
}
class AppLocale{
  Locale locale;

  AppLocale(this.locale);


  Map<String,String>_loadedLocalizedValues;

  static AppLocale of(BuildContext context){
    return Localizations.of<AppLocale>(context,AppLocale);

  }

  Future<AppLocale> loadLanguage()async{
    final String _langFile=await rootBundle.loadString('assets/langs/${locale.languageCode}.json');
    Map<String,dynamic>_loadedValues=jsonDecode(_langFile);
    _loadedLocalizedValues=_loadedValues.map((key,value)=>MapEntry(key,value));
  }
  String getTranslated(String key){
    return _loadedLocalizedValues[key];
  }

  static const LocalizationsDelegate<AppLocale> delegate =_AppLocaleDelegate();

}


class _AppLocaleDelegate extends LocalizationsDelegate<AppLocale>{
  const _AppLocaleDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','ar'].contains(locale.languageCode);
    // TODO: implement isSupported
    
  }

  @override
  Future<AppLocale> load(Locale locale)async {
    AppLocale appLocale=AppLocale(locale);
    await appLocale.loadLanguage();
    return appLocale;
    // TODO: implement load
    throw UnimplementedError();
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocale> old) {
    // TODO: implement shouldReload
    return false;
    throw UnimplementedError();
  }



}