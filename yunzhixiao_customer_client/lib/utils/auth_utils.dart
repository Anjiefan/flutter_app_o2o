


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/view_model/user/user_model.dart';

class ErrorUtils {
  static auth_401_error(BuildContext context,func) async {
    UserModel model = Provider.of<UserModel>(context);
    if (model.user == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("温馨提示"),
            content: new Text("登录后可以享受全部服务哦～"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("去登录"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                      context, RouteName.login)
                      .then((result) {
                    if (result) {
                      model.refreshUserInfo();
                      func();
                    }
                  });
                },
              ),
              new FlatButton(
                child: new Text("取消"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }
    func();
  }
}