import 'package:flutter/material.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/activity_indicator_widget.dart';

/// 由于app不管明暗模式,都是有底色
/// 所以将indicator颜色为亮色
class AppBarIndicator extends StatelessWidget {
  final double radius;

  AppBarIndicator({this.radius});

  @override
  Widget build(BuildContext context) {
    return ActivityIndicator(
      brightness: Brightness.dark,
      radius: radius,
    );
  }
}
