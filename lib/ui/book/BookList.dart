import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_gank/models/BookResp.dart';
import 'package:flutter_gank/ui/comm/LoadingMoreFooter.dart';
import 'package:flutter_gank/ui/comm/LoadingPage.dart';
import 'package:flutter_gank/ui/comm/MyWebview.dart';

class BookList extends StatefulWidget {
  final String category;

  const BookList({Key key, this.category}) : super(key: key);
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList>
    with AutomaticKeepAliveClientMixin {
  final List<BookContent> data = <BookContent>[];
  num currPage = 1;
  ScrollController _controller;

  @override
  bool get wantKeepAlive => true;

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
      currPage = 1;
      data.clear();
    }
    await Dio()
        .get(
            'http://gank.io/api/xiandu/data/id/${widget.category}/count/10/page/$currPage')
        .then((resp) {
      BookResp bookResp = BookResp.fromJson(resp.data);
      setState(() {
        data.addAll(bookResp.results);
      });
    }, onError: () {});
  }

  @override
  Widget build(BuildContext context) {
    return data.length == 0
        ? LoadingPage()
        : RefreshIndicator(
            onRefresh: () => _getData(true),
            child: ListView.builder(
              itemCount: 2 * data.length + 1,
              itemBuilder: (context, i) {
                if (i.isOdd) return Divider();
                if (i == 2 * data.length) return LoadingMoreFooter();
                final index = i ~/ 2;
                return _buildRow(data[index]);
              },
              controller: _controller,
            ),
          );
  }

  Widget _buildRow(BookContent content) {
    return ListTile(
      title: Text(content.title),
      leading: ClipOval(
        child: SizedBox(
          width: 25.0,
          height: 25.0,
          child: Image.network(
            content.site.icon,
            fit: BoxFit.cover,
          ),
        ),
      ),
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return MyWebview(title: content.title, url: content.url);
          })),
    );
  }
}
