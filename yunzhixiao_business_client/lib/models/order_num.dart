class OrderNum {
  int newOrder;
  int hurry;
  int cancel;
  int progressing;
  int finish;
  int slow;
  int preparing;
  int already;

  OrderNum(
      {this.newOrder,
      this.hurry,
      this.cancel,
      this.progressing,
      this.finish,
      this.slow,
      this.preparing,
      this.already});

  OrderNum.fromJson(Map<String, dynamic> json) {
    newOrder = json['new_order'];
    hurry = json['hurry'];
    cancel = json['cancel'];
    progressing = json['progressing'];
    finish = json['finish'];
    slow = json['slow'];
    preparing = json['preparing'];
    already = json['already'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['new_order'] = this.newOrder;
    data['hurry'] = this.hurry;
    data['cancel'] = this.cancel;
    data['progressing'] = this.progressing;
    data['finish'] = this.finish;
    data['slow'] = this.slow;
    data['preparing'] = this.preparing;
    data['already'] = this.already;
    return data;
  }
}
