import 'package:cloud_firestore/cloud_firestore.dart';

class QuizFirebaseService {
  final _quizCollection = FirebaseFirestore.instance.collection('quizs');

  Stream<QuerySnapshot> getProducts() {
    return _quizCollection.snapshots();
  }
}
