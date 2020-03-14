import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/view_model/user/login_model.dart';

import 'login_common_widgets.dart';
class LoginUsernamePasswordPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginUsernamePasswordPanelState();
}

class _LoginUsernamePasswordPanelState
    extends State<LoginUsernamePasswordPanel> {
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  final _pwdFocus = FocusNode();

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                    label: "请输入账号",
                    icon: Icons.perm_identity,
                    controller: _usernameController,
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.phone,
                    maxLength: 11,
                    onFieldSubmitted: (text) {
                      FocusScope.of(context)
                          .requestFocus(_pwdFocus);
                    },
                  ),
                  LoginTextField(
                    controller: _passwordController,
                    label: "请输入密码",
                    icon: Icons.lock_outline,
                    obscureText: true,
                    focusNode: _pwdFocus,
                    textInputAction: TextInputAction.done,
                  ),
                  LoginButton(_usernameController, _passwordController, 0),
                ]),
          )
        ],
      ),
    );
  }
}
