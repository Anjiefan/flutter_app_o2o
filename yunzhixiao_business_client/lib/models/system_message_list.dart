class SystemMessageList {
  SystemMessageListData data;

  SystemMessageList({this.data});

  SystemMessageList.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SystemMessageListData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class SystemMessageListData {
  List<SystemMessageOuter> data;
  int num;
  int unreadNum;

  SystemMessageListData({this.data, this.num, this.unreadNum});

  SystemMessageListData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<SystemMessageOuter>();
      json['data'].forEach((v) {
        data.add(new SystemMessageOuter.fromJson(v));
      });
    }
    num = json['num'];
    unreadNum = json['unread_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['num'] = this.num;
    data['unread_num'] = this.unreadNum;
    return data;
  }
}

class SystemMessageOuter {
  int id;
  SystemMessage systemMessage;
  int status;
  String date;
  String updateDate;

  SystemMessageOuter({this.id, this.systemMessage, this.status, this.date, this.updateDate});

  SystemMessageOuter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    systemMessage = json['system_message'] != null
        ? new SystemMessage.fromJson(json['system_message'])
        : null;
    status = json['status'];
    date = json['date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.systemMessage != null) {
      data['system_message'] = this.systemMessage.toJson();
    }
    data['status'] = this.status;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    return data;
  }
}

class SystemMessage {
  int id;
  String value;
  String type;
  String title;
  String img;

  SystemMessage({this.id, this.value, this.type, this.title, this.img});

  SystemMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    type = json['type'];
    title = json['title'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['type'] = this.type;
    data['title'] = this.title;
    data['img'] = this.img;
    return data;
  }
}

class SystemMessageNum {
  SystemMessageNumDetail data;

  SystemMessageNum({this.data});

  SystemMessageNum.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SystemMessageNumDetail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class SystemMessageNumDetail {
  int num;
  int unreadNum;

  SystemMessageNumDetail({this.num, this.unreadNum});

  SystemMessageNumDetail.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    unreadNum = json['unread_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = this.num;
    data['unread_num'] = this.unreadNum;
    return data;
  }
}

