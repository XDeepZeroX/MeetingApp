class User {
  int id;
  String firstName;
  String lastName;
  int age;
  int sex;
  String nickname;
  String email;
  String phoneNumber;
  String city;
  Null briefInformation;
  List<String> photos;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.age,
      this.sex,
      this.nickname,
      this.email,
      this.phoneNumber,
      this.city,
      this.briefInformation,
      this.photos});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    age = json['age'];
    sex = json['sex'];
    nickname = json['nickname'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    city = json['city'];
    briefInformation = json['briefInformation'];
    if (json['photos'] != null) {
      photos = (json['photos'] as List).map((e)=> e as String).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['age'] = this.age;
    data['sex'] = this.sex;
    data['nickname'] = this.nickname;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['city'] = this.city;
    data['briefInformation'] = this.briefInformation;
    data['photos'] = this.photos;
    return data;
  }
}
