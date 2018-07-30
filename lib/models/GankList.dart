import 'package:flutter_gank/models/GankItem.dart';

class GankList {
  final bool error;
  final List<GankItem> results;

  GankList(this.error, this.results);

  GankList.fromJson(Map<String, dynamic> json)
      : error = json['error'],
        results = formatedList(json['results']);

  static formatedList(list) {
    List<GankItem> ganklist = <GankItem>[];
    if (list != null) {
        list.forEach((v) {
            ganklist.add(GankItem.fromJson(v));
        });
    }
    return ganklist;
  }
}
