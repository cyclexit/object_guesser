class Label {
  final String id;
  final String text;

  const Label({required this.id, required this.text});

  Label.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        text = json["text"];
}
