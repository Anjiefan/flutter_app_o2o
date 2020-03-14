

import 'package:flutter/material.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';

class AppInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var theme = Theme.of(context);
    final size =MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('关于我们'),
        centerTitle: false,
      ),
      body: Container(
        color: Colors.white,
        child: Center(

          child: Container(
            margin: EdgeInsets.only(bottom: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(

                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 0),
                        blurRadius: 5,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child:  PhysicalModel(
                    color: Colors.green,
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(8),
                    child: WrapperImage(
                      url: 'http://lc-aveFaAUx.cn-n1.lcfile.com/89b0dceff76af220dd18/ic_launcher.png',
                      width: 100,
                      height: 100,
                    ),
                  ),

                ),
                SizedBox(height: 6,),
                Text('云智校用户端',style: TextStyle(color: Colors.black54),),
                SizedBox(height: 6,),
                Text('系统版本 V1.0.0',style: TextStyle(color: Colors.black26),),
                SizedBox(height: 6,),
                Text('黑龙江符瑞科技有限公司',style: TextStyle(color: Colors.black26,fontSize: 14),),
                SizedBox(height: 6,),
                Text('Heilongjiang Free Information Technology Co.,Ltd',style: TextStyle(color: Colors.black26,fontSize: 13),),
//                SizedBox(height: 6,),
//                Text('Create By:陶意凡、王晨星、贾玉鹏、张津钰',style: TextStyle(color: Colors.black26,fontSize: 13),),

              ],
            ),
          ),
        ),
      ),
    );
  }

}