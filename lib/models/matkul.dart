class Matkul {
    int mkId;
    String mkKode;
    String mkNama;
    String semester;
    int sks;
    dynamic type;
    dynamic createdAt;
    dynamic updatedAt;

    Matkul({
        required this.mkId,
        required this.mkKode,
        required this.mkNama,
        required this.semester,
        required this.sks,
        required this.type,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Matkul.fromJson(Map<String, dynamic> json) => Matkul(
        mkId: json["mk_id"],
        mkKode: json["mk_kode"],
        mkNama: json["mk_nama"],
        semester: json["semester"],
        sks: json["sks"],
        type: json["type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "mk_id": mkId,
        "mk_kode": mkKode,
        "mk_nama": mkNama,
        "semester": semester,
        "sks": sks,
        "type": type,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}