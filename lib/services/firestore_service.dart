import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:object_guesser/log.dart';
import 'package:object_guesser/models/label.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// A category is a label with `root_id` and `parent_id` equal to the its own
  /// `id`.
  Future<List<String>> getCategories() async {
    final ref = _db.collection('labels');
    final snapshot = await ref.get();
    // log.d(snapshot);
    final labels = snapshot.docs.map((e) => e.data());
    log.d(labels);
    List<String> categories = [];
    for (final label in labels) {
      if (label["id"] == label["root_id"]) {
        categories.add(label["name"]);
      }
    }
    return categories;
  }
}
