import 'package:flutter/material.dart';

Image getImage(String url) {
  // ignore: todo
  // TODO: when the server and the database is done, get the image from the
  // Internet instead of asset.

  // ignore: todo
  // TODO: find a way to keep the image original aspect ratio
  return Image.asset(
    url,
    height: 250,
    width: 250,
  );
}
