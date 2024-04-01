import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_chat/component/list_tile.dart';
import 'package:random_chat/screen/chat_detail.dart';
import 'package:random_chat/services/auth/auth_services.dart';
import 'package:random_chat/component/app_drawer.dart';
import 'package:random_chat/services/chat_services/chat_services.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _chatServices = ChatService();
  final authService = AuthService();

  User? logedInUser() {
    return _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    //services and auth class

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        elevation: 0,
        title: Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                authService.logout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatServices.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    return userData['email'] != logedInUser()!.email
        ? UserTile(
            name: userData['email'],
            onTab: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ChatDetail(
                      chatEmail: userData['email'],
                      receiverId: userData['uid'],
                    );
                  },
                ),
              );
            },
          )
        : Container();
  }
}
