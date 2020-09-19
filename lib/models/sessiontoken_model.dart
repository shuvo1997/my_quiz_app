import 'dart:convert';

SessionToken tokenFromJson(String str) =>
    SessionToken.fromJson(json.decode(str));

class SessionToken {
  SessionToken({
    this.responseCode,
    this.responseMessage,
    this.token,
  });

  int responseCode;
  String responseMessage;
  String token;

  factory SessionToken.fromJson(Map<String, dynamic> json) => SessionToken(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_message": responseMessage,
        "token": token,
      };
}
