import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gank/models/GankItem.dart';
import 'package:flutter_gank/models/GankList.dart';
import 'package:flutter_gank/ui/comm/LoadingMoreFooter.dart';
import 'package:flutter_gank/ui/comm/LoadingPage.dart';
import 'package:flutter_gank/ui/comm/MyWebview.dart';

class Web extends StatefulWidget {
  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web> {
  final List<GankItem> data = <GankItem>[];
  num currPage = 1;
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        var maxScroll = _controller.position.maxScrollExtent;
        var pixels = _controller.position.pixels;
        if (maxScroll - pixels < 200.0) {
          currPage++;
          _getData(false);
        }
      });
    _getData(true);
  }

  Future<Null> _getData(bool isRefresh) async {
    if (isRefresh) {
      data.clear();
      currPage = 1;
    }
    await Dio().get('http://gank.io/api/data/前端/10/$currPage').then(
        (resp) {
      GankList gankList = GankList.fromJson(resp.data);
      setState(() {
        data.addAll(gankList.results);
      });
    }, onError: () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('前端'),
      ),
      body: data.length == 0
          ? LoadingPage()
          : RefreshIndicator(
              child: ListView.builder(
                itemCount: 2 * data.length + 1,
                itemBuilder: (context, i) {
                  if (i.isOdd) return Divider(height: 1.0);
                  if (i == 2 * data.length) return LoadingMoreFooter();
                  final index = i ~/ 2;
                  return _buildRow(data[index]);
                },
                controller: _controller,
              ),
              onRefresh: () => _getData(true),
            ),
    );
  }

  Widget _buildRow(GankItem item) {
    return ListTile(
      title: Text(item.desc),
      subtitle: Text(item.who),
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return MyWebview(title: item.desc, url: item.url);
          })),
    );
  }
}