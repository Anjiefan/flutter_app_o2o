


import 'package:flutter/material.dart';

class CommonShadowContainer extends StatelessWidget{
  Widget child;
  EdgeInsetsGeometry padding;
//  EdgeInsetsGeometry margin;
  CommonShadowContainer({this.child,this.padding});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final size =MediaQuery.of(context).size;
    final width =size.width;
    return Container(
//        margin: margin??EdgeInsets.only(bottom: 0),
        padding: padding??EdgeInsets.only(bottom: 0),
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x80DCE7FA),
              offset: Offset(0, 2),
              blurRadius: 2,
            ),
          ],
        ),
        child:child
    );
  }
}

