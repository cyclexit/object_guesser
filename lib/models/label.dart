class Label {
  final String id;
  final String text;

  const Label({required this.id, required this.text});

  Label.fromJson(Map<String, dynamic> json)
      : id = json["id"]!.toString(),
        text = json["text"]!.toString();

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
      };
}
