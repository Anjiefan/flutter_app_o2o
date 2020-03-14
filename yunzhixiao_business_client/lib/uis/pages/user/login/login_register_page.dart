import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/service/user_repository.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/login/login_common_widgets.dart';
import 'package:yunzhixiao_business_client/view_model/user/login_model.dart';
import 'package:yunzhixiao_business_client/view_model/user/user_model.dart';

class LoginRegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginRegisterPageState();
}

class LoginRegisterPageState extends State<LoginRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("注册"),
        ),
        body: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    color: Theme.of(context).primaryColor,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          RegisterPanel()
                        ],
                      ),
                    ),
                  )
                ])));
  }
}


class RegisterPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPanelState();
}

class _RegisterPanelState extends State<RegisterPanel> {
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  TextEditingController _codeController;
  final _pwdFocus = FocusNode();
  final _usernameFocus = FocusNode();
  final _codeFocus = FocusNode();
  var isSent = false;
  var _seconds = 60;
  Timer _timer;
  var _verifyStr = "获取验证码";

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _codeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _codeController.dispose();
    _cancelTimer();
    super.dispose();
  }

  void _startTimer() {
    // 计时器（`Timer`）组件的定期（`periodic`）构造函数，创建一个新的重复计时器。
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        _seconds = 60;
        setState(() {
          isSent = false;
        });
        return;
      }
      _seconds--;
      setState(() {
        _verifyStr = '已发送$_seconds秒';
      });
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = '重新发送';
        isSent = false;
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    return ProviderWidget<LoginModel>(
      model: LoginModel(Provider.of(context)),
      onModelReady: (model){},
      builder: (context, model, child) {
        return Form(
          onWillPop: () async {
            return !model.busy;
          },
          child: child,
        );
      },
      child: Column(
        children: <Widget>[
          LoginPanelForm(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LoginTextField(
                    controller: _usernameController,
                    label: "手机号",
                    icon: Icons.phone_android,
                    inputType: TextInputType.phone,
                    maxLength: 11,
                    obscureText: false,
                    focusNode: _usernameFocus,
                    textInputAction: TextInputAction.done,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: LoginTextField(
                          controller: _codeController,
                          label: "验证码",
                          icon: Icons.vpn_key,
                          maxLength: 4,
                          inputType: TextInputType.number,
                          focusNode: _codeFocus,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 9,vertical: 2),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(_verifyStr,style: TextStyle(color: Colors.white),),
                          onPressed: isSent
                              ? null
                              : () {
                            UserRepository.getCode(_usernameController.text).then((result){
                              showToast("验证码已发送。");
                              setState(() {
                                isSent = true;
                              });
                              _startTimer();
                            });
                          },
                          elevation: 0,
                          focusElevation: 0,
                          color: Theme.of(context).primaryColor.withOpacity(0.9),
                          textColor: Colors.white,
                          disabledColor: Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                      )
                    ],
                  ),
                  LoginTextField(
                    controller: _passwordController,
                    label: "密码",
                    icon: Icons.lock_outline,
                    obscureText: true,
                    focusNode: _pwdFocus,
                    textInputAction: TextInputAction.done,
                  ),
                  RegisterButton(_codeController, _passwordController, _usernameController),
                ]),
          )
        ],
      ),
    );
  }
}