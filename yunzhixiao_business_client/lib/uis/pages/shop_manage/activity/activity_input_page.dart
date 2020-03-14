import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_business_client/uis/helpers/navigator_helper.dart';

class ActivityInputTextPage extends StatefulWidget {
  final model;

  ActivityInputTextPage(
      {Key key,
      @required this.title,
      this.content,
      this.hintText,
      this.keyboardType: TextInputType.text,
      this.model,
      @required this.textMaxLength})
      : super(key: key);

  final String title;
  final String content;
  final String hintText;
  final TextInputType keyboardType;
  final textMaxLength;

  @override
  _ActivityInputTextPageState createState() => _ActivityInputTextPageState();
}

class _ActivityInputTextPageState extends State<ActivityInputTextPage> {
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
              NavigatorHelper.goBackWithParams(context, "");
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
          child: Column(
            children: <Widget>[
              TextField(
                  maxLength: widget.textMaxLength,
                  maxLines: 1,
                  onChanged: (value) {
                    widget.model.promotion.discountPrice = double.parse(value);
                    widget.model.notifyListeners();
                  },
                  autofocus: true,
                  controller: _controller,
                  keyboardType: widget.keyboardType,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    border: InputBorder.none,
                    //hintStyle: TextStyles.textGrayC14
                  )),
              ListTile(
                title: Text(
                  '规则状态',
                  style: TextStyle(fontSize: 15),
                ),
                trailing: CupertinoSwitch(
                    value: widget.model.promotion.status == "启动" ? true : false,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (value) {
                      value
                          ? widget.model.promotion.status = "启动"
                          : widget.model.promotion.status = "停止";
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
