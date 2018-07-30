import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gank/models/GankItem.dart';
import 'package:flutter_gank/models/GankList.dart';
import 'package:flutter_gank/ui/comm/LoadingPage.dart';
import 'package:flutter_gank/ui/welfare/PhotoView.dart';

class Welfare extends StatefulWidget {
  @override
  _WelfareState createState() => _WelfareState();
}

class _WelfareState extends State<Welfare> with SingleTickerProviderStateMixin {
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

        if (maxScroll - pixels < 300.0) {
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
    await Dio().get('http://gank.io/api/data/福利/10/$currPage').then((resp) {
      GankList gankList = GankList.fromJson(resp.data);
      setState(() {
        data.addAll(gankList.results);
      });
    }, onError: () {});
  }

  void showPhoto(item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(item.desc),
            ),
            body: SizedBox.expand(
              child: Hero(tag: item.url, child: PhotoView(item: item)),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('福利'),
      ),
      body: data.length == 0
          ? LoadingPage()
          : RefreshIndicator(
              child: GridView.count(
                padding: EdgeInsets.all(4.0),
                crossAxisCount: 2,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                childAspectRatio: 1.0,
                children: data.map((item) {
                  return GestureDetector(
                    onTap: () => showPhoto(item),
                    child: Hero(
                      key: Key(item.url),
                      tag: item.url,
                      child: FadeInImage.assetNetwork(
                          placeholder: 'images/loading.png',
                          image: item.url,
                          fit: BoxFit.cover
                      ),
                    //   child: Image.network(
                    //     item.url,
                    //     fit: BoxFit.cover,
                    //   ),
                    ),
                  );
                }).toList(),
                controller: _controller,
              ),
              onRefresh: () => _getData(true),
            ),
    );
  }
}
