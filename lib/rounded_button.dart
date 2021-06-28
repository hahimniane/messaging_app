import 'package:flutter/material.dart';
import 'package:hashsik/screens/chat_screen.dart';
import 'package:hashsik/screens/login_screen.dart';
import 'package:hashsik/screens/registration_screen.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.colour,
      required this.label,
      required this.onPressed,
      required this.x});
  final Color colour;
  final String label;
  final Function onPressed;
  final int x;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            if (x == 1) {
              Navigator.pushNamed(context, LoginScreen.id);
            } else if (x == 2) {
              Navigator.pushNamed(context, RegistrationScreen.id);
            } else if (x == 3) {
              Navigator.pushNamed(context, ChatScreen.id);
            }
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            label,
          ),
        ),
      ),
    );
  }
}
