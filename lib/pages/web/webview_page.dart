import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebviewPage extends StatefulWidget {
  final String title;
  final String url;
  WebviewPage({Key key, @required this.title, @required this.url}) : super(key: key);

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: this.widget.url,
      appBar: AppBar(
        title: Text(this.widget.title, style: TextStyle(color: Colors.white)),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        color: Colors.redAccent,
        child: Center(
          child: Text('Waiting.....'),
        ),
      ),
    );
  }
}