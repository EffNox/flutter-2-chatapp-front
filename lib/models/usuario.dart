import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        this.online,
        this.id,
        this.nom,
        this.cor,
    });

    bool online;
    String id;
    String nom;
    String cor;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        online: json["online"],
        id: json["_id"],
        nom: json["nom"],
        cor: json["cor"],
    );

    Map<String, dynamic> toJson() => {
        "online": online,
        "_id": id,
        "nom": nom,
        "cor": cor,
    };
}
