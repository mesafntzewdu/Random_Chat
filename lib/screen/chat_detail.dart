import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_chat/component/message_bubble.dart';
import 'package:random_chat/services/auth/auth_services.dart';
import 'package:random_chat/services/chat_services/chat_services.dart';
import 'package:timestamp_to_string/timestamp_to_string.dart';

class ChatDetail extends StatefulWidget {
  const ChatDetail(
      {super.key, required this.chatEmail, required this.receiverId});

  final String chatEmail;
  final String receiverId;

  @override
  State<ChatDetail> createState() {
    return _ChatDetailState();
  }
}

class _ChatDetailState extends State<ChatDetail> {
  final TextEditingController _messageToSend = TextEditingController();

  final ChatService _service = ChatService();
  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageToSend.text.isNotEmpty) {
      await _service.sendMessage(widget.receiverId, _messageToSend.text.trim());
    }

    _messageToSend.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _messageToSend.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('chat detail'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildMessageList()),
            _userTextInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _service.getMessage(_auth.currentUser!.uid, widget.receiverId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Waiting');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> message = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = _auth.currentUser!.uid == message['senderId'];

    return ListTile(
      title: Bubble(
        message: message['message'],
        isSender: isCurrentUser,
      ),
    );
  }

// Text(
//         message['message'],
//         textAlign: isCurrentUser ? TextAlign.right : TextAlign.left,
//       ),
  Widget _userTextInput() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 55,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
              child: TextField(
                controller: _messageToSend,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'Write message....'),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.send,
            size: 30,
          ),
        )
      ],
    );
  }
}
