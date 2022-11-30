class Label {
  final String id;
  final String name;

  const Label({required this.id, this.name = ""});

  Label.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"] ?? "";

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
