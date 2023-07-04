import 'dart:convert';

class Config {
  GoogleConfig? google;

  AppleConfig? apple;

  Config({this.google, this.apple});

  static Config parse(String content) {
    var object = json.decode(content);
    GoogleConfig? google;
    AppleConfig? apple;

    if (object['google'] != null) {
      var googleObject = object['google'];
      var clientId = googleObject['clientId'];
      var redirectUrl = googleObject['redirectUrl'];
      var scopes = List.of(googleObject['scopes']).map((e) => '${e}').toList();
      google = GoogleConfig(clientId, redirectUrl, scopes);
    }

    if (object['apple'] != null) {
      var appleObject = object['apple'];
      var clientId = appleObject['clientId'];
      var redirectUrl = appleObject['redirectUrl'];
      var scopes = List.of(appleObject['scopes']).map((e) => '${e}').toList();
      apple = AppleConfig(clientId, redirectUrl, scopes);
    }

    return Config(google: google, apple: apple);
  }
}

class AppleConfig {
  String clientId;
  String redirectUrl;
  List<String> scopes;

  AppleConfig(this.clientId, this.redirectUrl, this.scopes);
}

class GoogleConfig {
  String clientId;
  String redirectUrl;
  List<String> scopes;

  GoogleConfig(this.clientId, this.redirectUrl, this.scopes);
}
