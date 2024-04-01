import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_chat/model/message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('Users').snapshots().map((snapshots) {
      return snapshots.docs.map((e) {
        final user = e.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String receiverId, String message) async {
    try {
      final String currentUserId = _auth.currentUser!.uid;
      final String currentUserEmail = _auth.currentUser!.email!;

      Message newMessage = Message(
        message: message,
        receiverId: receiverId,
        senderEmail: currentUserEmail,
        senderId: currentUserId,
        timestamp: Timestamp.now(),
      );

      List<String> ids = [currentUserId, receiverId];
      ids.sort();
      String chatRoomId = ids.join('_');

      await _firestore
          .collection('chat_room')
          .doc(chatRoomId)
          .collection('message')
          .add(newMessage.toMap());
    } catch (e) {
      print("Error sending message: $e");
      // Handle error appropriately, e.g., show error message to user
    }
  }

  Stream<QuerySnapshot> getMessage(String currentUserId, String receiverId) {
    try {
      List<String> ids = [currentUserId, receiverId];
      ids.sort();
      String chatRoomId = ids.join('_');

      return _firestore
          .collection('chat_room')
          .doc(chatRoomId)
          .collection('message')
          .orderBy('timeStamp', descending: false)
          .snapshots();
    } catch (e) {
      return Stream.empty();
    }
  }
}
