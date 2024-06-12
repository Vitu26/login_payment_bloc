import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FirebaseFirestore firestore;

  ChatBloc(this.firestore) : super(ChatInitial()) {
    on<SendMessage>((event, emit) async {
      await firestore.collection('messages').add({'text': event.message, 'timestamp': FieldValue.serverTimestamp()});
      emit(MessageSent());
    });

    on<ReceiveMessages>((event, emit) async {
      firestore.collection('messages').orderBy('timestamp').snapshots().listen((snapshot) {
        List<String> messages = [];
        for (var doc in snapshot.docs) {
          messages.add(doc['text']);
        }
        emit(MessagesLoaded(messages));
      });
    });
  }
}
