

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorHelper{

  static pushResult(BuildContext context, Widget scene, Function(Object) function) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (BuildContext context) => scene,
      ),
    ).then((result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((error) {
      print('$error');
    });
  }

  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }

}