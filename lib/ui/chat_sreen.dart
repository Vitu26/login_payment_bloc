import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../blocs/chat/chat_bloc.dart';
import '../blocs/chat/chat_event.dart';
import '../blocs/chat/chat_state.dart';

class ChatScreen extends StatelessWidget {
  final ChatBloc chatBloc = ChatBloc(FirebaseFirestore.instance);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chatBloc..add(ReceiveMessages()),
      child: Scaffold(
        appBar: AppBar(title: Text('Chat')),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is MessagesLoaded) {
                    return ListView.builder(
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.messages[index]),
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: (text) {
                        chatBloc.add(SendMessage(text));
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      // Retrieve the text from the TextField and send it
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
