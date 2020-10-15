import 'dart:convert';

MensajeRs mensajeRsFromJson(String str) => MensajeRs.fromJson(json.decode(str));

String mensajeRsToJson(MensajeRs data) => json.encode(data.toJson());

class MensajeRs {
  MensajeRs({this.dt});

  List<Mensaje> dt;

  factory MensajeRs.fromJson(Map<String, dynamic> json) => MensajeRs(
        dt: List<Mensaje>.from(json["dt"].map((x) => Mensaje.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dt": List<dynamic>.from(dt.map((x) => x.toJson())),
      };
}

class Mensaje {
  Mensaje({
    this.id,
    this.from,
    this.to,
    this.msg,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String from;
  String to;
  String msg;
  DateTime createdAt;
  DateTime updatedAt;

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        id: json["_id"],
        from: json["from"],
        to: json["to"],
        msg: json["msg"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "from": from,
        "to": to,
        "msg": msg,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
