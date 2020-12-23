class Message {
  int id;
  int userId;
  String text;
  int dateCreateUnix;
  DateTime dateCreate;
  String get timeCreate => '${dateCreate.hour}:${dateCreate.minute}';

  Message(
      {this.id, this.userId, this.text, this.dateCreateUnix, this.dateCreate});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    text = json['text'];
    dateCreateUnix = json['dateCreateUnix'];
    dateCreate = DateTime.fromMillisecondsSinceEpoch(dateCreateUnix * 1000);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['text'] = this.text;
    data['dateCreateUnix'] = this.dateCreateUnix;
    data['dateCreate'] =
        this.dateCreate.toUtc().toString().split(' ').join('T');
    return data;
  }
}
