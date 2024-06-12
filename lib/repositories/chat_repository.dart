import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository {
  final FirebaseFirestore firestore;

  ChatRepository(this.firestore);

  Future<void> sendMessage(String message) {
    return firestore.collection('messages').add({'text': message, 'timestamp': FieldValue.serverTimestamp()});
  }

  Stream<List<String>> getMessages() {
    return firestore.collection('messages').orderBy('timestamp').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc['text'].toString()).toList();
    });
  }
}
