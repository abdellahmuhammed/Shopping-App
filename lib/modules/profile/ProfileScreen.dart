import 'package:flutter/material.dart';
import 'package:shopapp/shared/styles/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: grey,
        child: const Text('Profile Screen'),
      ),
    );
  }
}
