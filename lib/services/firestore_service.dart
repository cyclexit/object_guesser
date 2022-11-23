import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:object_guesser/models/label.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// A category is a label with `root_id` and `parent_id` equal to the its own
  /// `id`.
  Future<List<Label>> getCategories() async {
    final ref = _db.collection('labels');
    final snapshot = await ref.get();
    final labels = snapshot.docs.map((e) => e.data());
    List<Label> categories = [];
    for (final label in labels) {
      if (label["id"] == label["root_id"]) {
        categories.add(Label.fromJson(label));
      }
    }
    return categories;
  }
}
