import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:app_tnh2/model/article/modelArticle.dart' as ar;

class ProviderHome with ChangeNotifier {
  int notiCount = 0;
  int get dataNotiCount => notiCount;
  set setNotiCount(count) {
    notiCount = count;
    notifyListeners();
  }

  String updatePolicy = '';
  String get dataUpdatePolicy => updatePolicy;
  set setUpdatePolicy(value) {
    updatePolicy = value;
  }

  String cardID = '';
  String get dataCardID => cardID;
  set setCardID(value) {
    cardID = value;
  }

  String passsword = '';
  String get dataPasssword => passsword;
  set setPasssword(value) {
    passsword = value;
  }

  List<ar.ResDatum> articleSearch = [];
  List<ar.ResDatum> get dataArticleSearch => articleSearch;
  set setArticleSearch(value) {
    articleSearch = value;
  }
}
