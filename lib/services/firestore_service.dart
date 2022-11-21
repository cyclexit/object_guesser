import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:object_guesser/log.dart';
import 'package:object_guesser/models/label.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Label>> getCategories() async {
    final ref = _db.collection('labels');
    final snapshot = await ref.get();
    // log.d(snapshot);
    final data = snapshot.docs.map((e) => e.data());
    log.d(data);
    List<Label> categories = [];
    return categories;
  }
}
