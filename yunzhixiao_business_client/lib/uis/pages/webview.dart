import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yunzhixiao_business_client/uis/widgets/app_bar_widget.dart';
import 'package:yunzhixiao_business_client/utils/string_utils.dart';


class WebViewPage extends StatefulWidget {
  final String title;
  final String url;
  WebViewPage({
    this.title,
    this.url
  });

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewPage> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  Completer<bool> _finishedCompleter = Completer();

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      debugPrint('onStateChanged: ${state.type} ${state.url}');
      if (!_finishedCompleter.isCompleted &&
          state.type == WebViewState.finishLoad) {
        _finishedCompleter.complete(true);
      }
    });
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      withJavascript: true,
      displayZoomControls: true,
      withZoom: true,
      appBar: AppBar(
        title: WebViewTitle(
          title: widget.title,
          future: _finishedCompleter.future,
        ),
        actions: <Widget>[
          IconButton(
//            tooltip: '用浏览器打开',
            icon: Icon(Icons.language),
            onPressed: () {
              launch(widget.url, forceSafariVC: false);
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(widget.url, subject: widget.title);
            },
          ),
        ],
      ),
      bottomNavigationBar: IconTheme(
        data: Theme.of(context).iconTheme.copyWith(opacity: 0.5),
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: flutterWebViewPlugin.goBack,
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: flutterWebViewPlugin.goForward,
              ),
              IconButton(
                icon: const Icon(Icons.autorenew),
                onPressed: flutterWebViewPlugin.reload,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WebViewTitle extends StatelessWidget {
  final String title;
  final Future<bool> future;

  WebViewTitle({this.title, this.future});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FutureBuilder<bool>(
          future: future,
          initialData: false,
          builder: (context, snapshot) => snapshot.data
              ? SizedBox.shrink()
              : Padding(
              padding: EdgeInsets.only(right: 5), child: AppBarIndicator()),
        ),
        Expanded(
            child: Text(
              //移除html标签
              StringUtils.removeHtmlLabel(title),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ))
      ],
    );
  }
}