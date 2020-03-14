import 'package:yunzhixiao_customer_client/models/red_packet.dart';

class RedPacketList {
  List<RedPacket> data;

  RedPacketList({this.data});

  RedPacketList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<RedPacket>();
      json['data'].forEach((v) {
        data.add(new RedPacket.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}