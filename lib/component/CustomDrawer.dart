import 'package:flutter/material.dart';
import 'package:movie_apps/main.dart';
import 'package:movie_apps/screen/main_screen.dart';
import 'package:movie_apps/screen/profile/profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
              title: Text(
                'Movie List App',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: null),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProfileScreen();
              }));
            },
          ),
        ],
      ),
    );
  }
}
