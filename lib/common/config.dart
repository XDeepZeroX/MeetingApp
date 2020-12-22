class Config {
  static String authUrl;
  static String grassUrl;

  Config();

  Config.fromJson(Map<String, dynamic> json) {
    Config.authUrl = json['auth_url'];
    Config.grassUrl = json['grass_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth_url'] = Config.authUrl;
    data['grass_url'] = Config.grassUrl;
    return data;
  }
}
