import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MyWebview extends StatefulWidget {
  final String title;
  final String url;

  MyWebview({Key key, this.title, this.url}) : super(key: key);

  @override
  _MyWebviewState createState() => _MyWebviewState();
}

class _MyWebviewState extends State<MyWebview> {
  bool loading = true;

  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onStateChanged.listen((state) {});

    flutterWebViewPlugin.onUrlChanged.listen((state) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    titleContent.add(Text(widget.title, style: TextStyle(color: Colors.white)));
    if (loading) titleContent.add(CupertinoActivityIndicator());
    titleContent.add(Container(width: 50.0));
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: titleContent),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}
