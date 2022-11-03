// ignore: todo
// TODO: temporary class
//       remove this when the server is done
import 'package:object_guesser/models/image.dart';
import 'package:object_guesser/models/label.dart';

class Pair<T1, T2> {
  final T1 first;
  final T2 second;

  Pair(this.first, this.second);
}

class CsvParser {
  static const String _imageLabelRecordCsvPath = 'data/image_label_record.csv';
  static const String _imageCsvPath = 'data/image.csv';
  static const String _labelCsvPath = 'data/label.csv';

  List<Pair<String, String>>? imageLabelRecordList;
  List<ImageData>? imageList;
  List<Label>? labelList;
}
