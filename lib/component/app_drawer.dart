import 'package:flutter/material.dart';
import 'package:random_chat/services/auth/auth_services.dart';
import 'package:random_chat/screen/settings.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isDarkMode = false;
  @override
  Widget build(context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
              color: Theme.of(context).colorScheme.primary,
              Icons.message,
              size: 45,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 22),
            title: Text(
              'H O M E',
              style: Theme.of(context)
                  .textTheme
                  .copyWith(
                      titleLarge: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold))
                  .titleLarge,
            ),
            leading: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.primary,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 22),
            title: Text(
              'S E T T I N G S',
              style: Theme.of(context)
                  .textTheme
                  .copyWith(
                      titleLarge: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold))
                  .titleLarge,
            ),
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.primary,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const Settings();
              }));
            },
          ),
          const Spacer(),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 15),
            title: Text(
              'L O G O U T',
              style: Theme.of(context)
                  .textTheme
                  .copyWith(
                      titleLarge: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold))
                  .titleLarge,
            ),
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.primary,
              size: 30,
            ),
            onTap: () {
              final authService = AuthService();
              authService.logout();
            },
          ),
        ],
      ),
    );
  }
}
