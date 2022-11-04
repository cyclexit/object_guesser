class ImageData {
  String id;
  String url;

  ImageData({required this.id, required this.url});

  ImageData.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        url = json["url"];
}
