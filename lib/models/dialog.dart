import 'user.dart';

class MDialog {
  int id;
  String title;
  List<User> users;
  int createUserId;
  User createUser;

  MDialog(
      {this.id, this.title, this.users, this.createUserId, this.createUser});

  MDialog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['users'] != null) {
      users = new List<User>();
      json['users'].forEach((v) {
        users.add(User.fromJson(v));
      });
    }
    createUserId = json['createUserId'];
    if (json['createUser'] != null)
      createUser = User.fromJson(json['createUser']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.users != null) {
      data['users'] = this.users.map((v) => v.toJson()).toList();
    }
    data['createUserId'] = this.createUserId;
    data['createUser'] = this.createUser.toJson();
    return data;
  }
}
