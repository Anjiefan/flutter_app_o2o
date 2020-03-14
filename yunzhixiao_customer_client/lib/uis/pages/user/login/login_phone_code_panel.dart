import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_customer_client/commons/nets/handler.dart';
import 'package:yunzhixiao_customer_client/commons/nets/net_message.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/service/user_repository.dart';
import 'package:yunzhixiao_customer_client/view_model/user/login_model.dart';

import 'login_common_widgets.dart';

class LoginPhoneCodePanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPhoneCodePanelState();
}

class _LoginPhoneCodePanelState extends State<LoginPhoneCodePanel> {
  TextEditingController _phoneController;
  TextEditingController _codeController;
  final _pwdFocus = FocusNode();
  var isSent = false;
  var _seconds = 60;
  Timer _timer;
  var _verifyStr = "获取验证码";

  @override
  void initState() {
    _phoneController = TextEditingController();
    _codeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
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
                    label: "请输入手机号",
                    icon: Icons.call,
                    controller: _phoneController,
                    inputType: TextInputType.phone,
                    maxLength: 11,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (text) {
                      FocusScope.of(context).requestFocus(_pwdFocus);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: LoginTextField(
                          controller: _codeController,
                          label: "请输入验证码",
                          icon: Icons.vpn_key,
                          maxLength: 4,
                          inputType: TextInputType.number,
                          focusNode: _pwdFocus,
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
                            UserRepository.getCode(_phoneController.text).then((result){
                              showToast("验证码已发送。");
                              setState(() {
                                isSent = true;
                              });
                              _startTimer();
                            }).catchError((e){
                              Future.microtask(() {
                                showToast(ResponseMessage(Handler.errorHandleFunction(e.response.statusCode),e.response.data).message, context: context);
                              });
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
                  LoginButton(_phoneController, _codeController, 1),
                ]),
          )
        ],
      ),
    );
  }
}
