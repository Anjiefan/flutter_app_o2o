
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';

class BannerWidget extends StatelessWidget {
  BannerWidget({this.list, this.height});
  final double height;
  var list;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height!=null?height:80,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Swiper(
        loop: false,
        autoplay: true,
        autoplayDelay: 5000,
//        pagination: SwiperPagination(),
        itemCount: list.length,
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {
              if(list[index].isWeb==true){
                Navigator.pushNamed(context, RouteName.webView,arguments: [list[index].nav,'${list[index].name}']);
              }
              else{
                Navigator.pushNamed(context, '${list[index].nav}');
              }

            },
            child: BannerImage(
              list[index]?.url??''
              ));
        },
      )
    );
  }
}

class BannerImage extends StatelessWidget {
  final String url;
  final BoxFit fit;

  BannerImage(this.url, {this.fit: BoxFit.fill});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) =>
            Center(child: CupertinoActivityIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: fit);
  }
}