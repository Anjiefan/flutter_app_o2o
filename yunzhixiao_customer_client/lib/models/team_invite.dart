import 'package:yunzhixiao_customer_client/models/user.dart';

class TeamInviteList {
  List<TeamInvite> data;

  TeamInviteList({this.data});

  TeamInviteList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<TeamInvite>();
      json['data'].forEach((v) {
        data.add(new TeamInvite.fromJson(v));
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

class TeamInvite {
  User invite;

  TeamInvite({this.invite});

  TeamInvite.fromJson(Map<String, dynamic> json) {
    invite =
    json['invite'] != null ? new User.fromJson(json['invite']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.invite != null) {
      data['invite'] = this.invite.toJson();
    }
    return data;
  }
}