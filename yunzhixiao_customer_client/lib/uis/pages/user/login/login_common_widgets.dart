import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/button_progress_indicator_widget.dart';
import 'package:yunzhixiao_customer_client/view_model/user/login_model.dart';

//登录按钮功能
class LoginButton extends StatelessWidget {
  final nameController;
  final passwordController;
  final type;

  LoginButton(this.nameController, this.passwordController, this.type);

  bool isBusy = false;

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LoginModel>(context);
    return LoginButtonWidget(
      child: model.busy
          ? ButtonProgressIndicator()
          : Text(
              "登录",
              style: Theme.of(context)
                  .accentTextTheme
                  .title
                  .copyWith(wordSpacing: 6),
            ),
      onPressed: model.busy
          ? null
          : () {
              var formState = Form.of(context);
              if (formState.validate()) {
                if (type == 0) {
                  model
                      .loginUsernamePassword(
                          nameController.text, passwordController.text, context)
                      .then((value) {
                    if (value) {
                      showToast("登录成功！");
                      Navigator.of(context).pop(true);
                    } else {}
                  });
                } else if (type == 1) {
                  model
                      .loginUsernameCode(
                          nameController.text, passwordController.text, context)
                      .then((value) {
                    if (value) {
//              Navigator.of(context).pop(true);
                      showToast("登录成功！");
                      Navigator.of(context).pop(true);
                    } else {}
                  });
                }
              }
            },
    );
  }
}

class ChangePasswordButton extends StatelessWidget {
  final codeController;
  final passwordController;
  final newPasswordController;

  ChangePasswordButton(
      this.codeController, this.passwordController, this.newPasswordController);

  bool isBusy = false;

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LoginModel>(context);
    return LoginButtonWidget(
      child: model.busy
          ? ButtonProgressIndicator()
          : Text(
              "修改密码",
              style: Theme.of(context)
                  .accentTextTheme
                  .title
                  .copyWith(wordSpacing: 6),
            ),
      onPressed: model.busy
          ? null
          : () {
              var formState = Form.of(context);
              if (formState.validate()) {
                if (passwordController.text != newPasswordController.text) {
                  showToast("两次输入密码不一致");
                  return;
                }
                model
                    .changePassword(
                        codeController.text, passwordController.text, context)
                    .then((value) {
                  if (value) {
                    showToast("密码修改成功，请重新登录。");
                    model.logout();
                    Navigator.pushReplacementNamed(context, RouteName.login);
                  } else {
                    model.showErrorMessage(context);
                  }
                });
              }
            },
    );
  }
}

class RegisterButton extends StatelessWidget {
  final codeController;
  final passwordController;
  final usernameController;

  RegisterButton(
      this.codeController, this.passwordController, this.usernameController);

  bool isBusy = false;

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LoginModel>(context);
    return LoginButtonWidget(
      child: model.busy
          ? ButtonProgressIndicator()
          : Text(
              "注册",
              style: Theme.of(context)
                  .accentTextTheme
                  .title
                  .copyWith(wordSpacing: 6),
            ),
      onPressed: model.busy
          ? null
          : () {
              //正常环境代码开始
              var formState = Form.of(context);
              if (formState.validate()) {
                model
                    .register(codeController.text, passwordController.text,
                        usernameController.text, context)
                    .then((value) {
                  if (value) {
                    showToast("用户注册成功！");
                    Navigator.of(context).pop(true);
                  } else {
                    model.showErrorMessage(context);
                  }
                });
              }
              //正常环境代码结束
            },
    );
  }
}

//登录按钮样式
class LoginButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  LoginButtonWidget({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor.withOpacity(0.8);
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: CupertinoButton(
          padding: EdgeInsets.all(0),
          color: color,
          disabledColor: color,
          borderRadius: BorderRadius.circular(110),
          pressedOpacity: 0.5,
          child: child,
          onPressed: onPressed,
        ));
  }
}

//登录页面文本框
class LoginTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;
  final int maxLength;
  final TextInputType inputType;

  LoginTextField(
      {this.label,
      this.icon,
      this.controller,
      this.obscureText: false,
      this.validator,
      this.focusNode,
      this.textInputAction,
      this.onFieldSubmitted,
      this.maxLength,
      this.inputType});

  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  TextEditingController controller;

  /// 默认遮挡密码
  ValueNotifier<bool> obscureNotifier;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    obscureNotifier = ValueNotifier(widget.obscureText);
    super.initState();
  }

  @override
  void dispose() {
    obscureNotifier.dispose();
    // 默认没有传入controller,需要内部释放
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ValueListenableBuilder(
        valueListenable: obscureNotifier,
        builder: (context, value, child) => TextFormField(
          maxLength: widget.maxLength,
          maxLengthEnforced: true,
          keyboardType: widget.inputType,
          controller: controller,
          obscureText: value,
          validator: (text) {
            var validator = widget.validator ?? (_) => null;
            return text.trim().length > 0 ? validator(text) : "请填写内容";
          },
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
            counterStyle: TextStyle(
              height: double.minPositive,
            ),
            counterText: "",
            prefixIcon: Icon(widget.icon, color: theme.accentColor, size: 22),
            hintText: widget.label,
            hintStyle: TextStyle(fontSize: 16),
            suffixIcon: LoginTextFieldSuffixIcon(
              controller: controller,
              obscureText: widget.obscureText,
              obscureNotifier: obscureNotifier,
            ),
          ),
        ),
      ),
    );
  }
}

class LoginTextFieldSuffixIcon extends StatelessWidget {
  final TextEditingController controller;

  final ValueNotifier<bool> obscureNotifier;

  final bool obscureText;

  LoginTextFieldSuffixIcon(
      {this.controller, this.obscureNotifier, this.obscureText});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Offstage(
          offstage: !obscureText,
          child: InkWell(
            onTap: () {
//              debugPrint('onTap');
              obscureNotifier.value = !obscureNotifier.value;
            },
            child: ValueListenableBuilder(
              valueListenable: obscureNotifier,
              builder: (context, value, child) => Icon(
                CupertinoIcons.eye,
                size: 30,
                color: value ? theme.hintColor : theme.accentColor,
              ),
            ),
          ),
        ),
        LoginTextFieldClearIcon(controller)
      ],
    );
  }
}

class LoginTextFieldClearIcon extends StatefulWidget {
  final TextEditingController controller;

  LoginTextFieldClearIcon(this.controller);

  @override
  _LoginTextFieldClearIconState createState() =>
      _LoginTextFieldClearIconState();
}

class _LoginTextFieldClearIconState extends State<LoginTextFieldClearIcon> {
  ValueNotifier<bool> notifier;

  @override
  void initState() {
    notifier = ValueNotifier(widget.controller.text.isEmpty);
    widget.controller.addListener(() {
      if (mounted) notifier.value = widget.controller.text.isEmpty;
    });
    super.initState();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, bool value, child) {
        return Offstage(
          offstage: value,
          child: child,
        );
      },
      child: InkWell(
          onTap: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.controller.clear();
            });
          },
          child: Icon(CupertinoIcons.clear,
              size: 30, color: Theme.of(context).hintColor)),
    );
  }
}

//登录页面表单
class LoginPanelForm extends StatelessWidget {
  final Widget child;

  LoginPanelForm({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          color: Theme.of(context).cardColor,
          shadows: [
            BoxShadow(
                color: Theme.of(context).primaryColor.withAlpha(20),
                offset: Offset(1.0, 1.0),
                blurRadius: 10.0,
                spreadRadius: 3.0),
          ]),
      child: child,
    );
  }
}
