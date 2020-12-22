class Config {
  static String serverUrl;

  Config();

  Config.fromJson(Map<String, dynamic> json) {
    Config.serverUrl = json['server_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['server_url'] = Config.serverUrl;
    return data;
  }
}
