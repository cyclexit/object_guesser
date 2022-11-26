class Label {
  final String id;
  final String parentId;
  final String rootId;
  final String name;

  const Label(
      {required this.id,
      required this.parentId,
      required this.rootId,
      required this.name});

  Label.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        parentId = json["parent_id"],
        rootId = json["root_id"],
        name = json["name"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "root_id": rootId,
        "name": name,
      };
}
