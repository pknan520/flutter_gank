// import 'GankItem.dart';

import 'package:flutter_gank/models/GankItem.dart';

class Gank {
  final List<String> category;
  final bool error;
  final Map<String, List<GankItem>> results;

  Gank(this.category, this.error, this.results);

  Gank.fromJson(Map<String, dynamic> json)
      : category = formatedString(json['category']),
        error = json['error'],
        results = formatedResults(json['results']);

  Map<String, dynamic> toJson() =>
      {'category': category, 'error': error, 'results': results};

  static formatedString(list) {
    List<String> category = [];
    if (list != null) {
      list.forEach((v) {
        category.add(v.toString());
      });
    }
    return category;
  }

  static formatedResults(Map map) {
    Map<String, List<GankItem>> results = Map();
    if (map != null) {
      map.forEach((key, val) {
        List<GankItem> list = [];
        if (val != null) {
          val.forEach((v) {
            list.add(GankItem.fromJson(v));
          });
        }
        results.addAll({key: list});
      });
    }
    return results;
  }
}


