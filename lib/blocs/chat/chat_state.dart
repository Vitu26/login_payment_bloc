abstract class ChatState {}

class ChatInitial extends ChatState {}

class MessageSent extends ChatState {}

class MessagesLoaded extends ChatState {
  final List<String> messages;
  MessagesLoaded(this.messages);
}
