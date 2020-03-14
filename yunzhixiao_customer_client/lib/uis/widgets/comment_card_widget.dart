

import 'package:flutter/material.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';

class CommentCard extends StatelessWidget{
  String img;
  String content;
  String date;
  String username;
  int good;
  CommentCard({this.img,this.date,this.content,this.username,this.good});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            PhysicalModel(
                              color: Colors.transparent,
                              borderRadius:
                              BorderRadius.circular(4),
                              clipBehavior: Clip.antiAlias,
                              child: WrapperImage(
                                url:
                                img,
                                width: 40,
                                height: 40,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  username,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                                SizedBox(height: 10),
                                good == 1 ?
                                Icon(Icons.thumb_up, color: Colors.amber, size: 14,):
                                Icon(Icons.thumb_down, color: Colors.grey, size: 14,)

                              ],
                            ),
                          ],
                        ),
                        Text(
                          date.substring(0, 10),
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          50, 16, 16, 16),
                      child: Row(
                        children: <Widget>[
                          Text(
                            content,
                            style: TextStyle(
                                color: Colors.black87),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider()
            ],
          ),
        ));
  }
}

