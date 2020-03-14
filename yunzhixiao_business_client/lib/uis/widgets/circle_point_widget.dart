
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CirclePointWidget extends StatelessWidget{

  final Color color;

  const CirclePointWidget({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    // TODO: implement build
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color:color==null?theme.primaryColor:color,
            borderRadius:
            BorderRadius.all(Radius.circular(30))
        ),
      ),
    );
  }
}