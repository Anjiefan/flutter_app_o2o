import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TypeCard extends StatelessWidget{
  String name;
  Color bgColor;
  Color fontColor;
  Icon icon;
  VoidCallback onPressed;
  TypeCard({this.name
    ,this.bgColor
    ,this.fontColor
    ,this.onPressed
    ,this.icon
    });
  @override
  Widget build(BuildContext context) {
    return  FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: onPressed,
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
          decoration: BoxDecoration(
              color: bgColor,
              border: Border(
                left: Divider.createBorderSide(context, width: 1),
                top: Divider.createBorderSide(context, width:   1),
                bottom: Divider.createBorderSide(context, width: 1),
                right: Divider.createBorderSide(context, width: 1),)),
          child: Row(
            children: <Widget>[
              Text(name,style: TextStyle(color: fontColor),),
              icon!=null?icon:Container()
            ],
          )
      ),
    );
  }

}