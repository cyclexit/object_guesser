class ImageData {
  final String id;
  final String url;

  ImageData({required this.id, required this.url});

  ImageData.fromJson(Map<String, dynamic> json)
      : id = json["id"]!.toString(),
        url = json["url"]!.toString();

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
