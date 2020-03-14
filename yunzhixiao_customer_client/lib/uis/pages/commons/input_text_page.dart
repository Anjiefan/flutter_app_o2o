import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_customer_client/uis/helpers/navigator_helper.dart';

class InputTextPage extends StatefulWidget {
  InputTextPage(
      {Key key,
      @required this.title,
      this.content,
      this.hintText,
      this.keyboardType: TextInputType.text,
      @required this.textMaxLength})
      : super(key: key);

  final String title;
  final String content;
  final String hintText;
  final TextInputType keyboardType;
  final textMaxLength;

  @override
  _InputTextPageState createState() => _InputTextPageState();
}

class _InputTextPageState extends State<InputTextPage> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          RaisedButton(
            elevation: 0,
            focusElevation: 0,
            child: Text(
              "完成",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColor,
            onPressed: () {
              if (_controller.text == null || _controller.text.trim() == "") {
                showToast("内容不能为空");
                return;
              }
              NavigatorHelper.goBackWithParams(context, _controller.text);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 21.0, left: 16.0, right: 16.0, bottom: 16.0),
        child: Semantics(
          multiline: true,
          maxValueLength: widget.textMaxLength,
          child: TextField(
              maxLength: widget.textMaxLength,
              maxLines: 1,
              autofocus: true,
              controller: _controller,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                //hintStyle: TextStyles.textGrayC14
              )),
        ),
      ),
    );
  }
}
