import 'package:flutter/material.dart';

Size displaySize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  return displaySize(context).width;
}

Size percentageSize(BuildContext context, double percentage) {
  return displaySize(context) * percentage;
}

double percentageHeight(BuildContext context, double percentage) {
  return displayHeight(context) * percentage;
}

double percentageWidth(BuildContext context, double percentage) {
  return displaySize(context).width * percentage;
}
