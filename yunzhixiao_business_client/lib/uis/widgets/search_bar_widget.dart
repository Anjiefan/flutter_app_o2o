import 'dart:ui';

import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function onTap;

  const SearchBarWidget({Key key, this.onTap, this.controller})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchBarWidgetState();
}

class SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        bottom: 12,
        right: 12,
        top: 12,
      ),
      decoration: new BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: SearchBar(
            searchBarWidth: MediaQuery.of(context).size.width * 0.85,
            controller: widget.controller,
          )),
          GestureDetector(
              child: new Container(
                alignment: Alignment(0, 0),
                margin: EdgeInsets.only(left: 12),
                height: 32,
                child: Text("搜索",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
              onTap: widget.onTap)
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  double searchBarWidth;
  TextEditingController controller;
  final hintText;
  final Function onTextChange;
  final VoidCallback cancelCallBack;
  SearchBar(
      {Key key, @required this.searchBarWidth, this.controller, this.hintText, this.onTextChange
      ,this.cancelCallBack})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new SearchBarState(
      searchBarWidth: searchBarWidth, controller: controller);
}

class SearchBarState extends State<SearchBar> {
  SearchBarState({Key key, @required this.searchBarWidth, this.controller})
      : super();
  TextEditingController controller;
  FocusNode _focusNode = FocusNode();
  double searchBarWidth;

  @override
  void initState() {
    if (controller != null) {
      controller.addListener(() {
        if (!mounted) return;
        setState(() {});
      });
    }

    super.initState();
  }

  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[100],
      ),
      width: searchBarWidth,
      height: 32,
      padding: EdgeInsets.only(bottom: 0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new SizedBox(
            width: 5.0,
          ),
          new Icon(
            Icons.search,
            color: Colors.grey[400],
          ),
          new Expanded(
            child: Container(
              alignment: Alignment.center,
              child: new TextField(
                controller: controller,
                focusNode: _focusNode,
                onChanged: widget.onTextChange,
                decoration: null,
                // onChanged: onSearchTextChanged,
              ),
            ),
          ),
          _focusNode.hasFocus
              ? new IconButton(
                  icon: new Icon(Icons.cancel),
                  color: Colors.grey,
                  iconSize: 18.0,
                  onPressed: () {
                    controller.clear();
                    if(widget.cancelCallBack!=null){
                      widget.cancelCallBack();
                    }
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
