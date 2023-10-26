import 'package:flutter/material.dart';

class ProfileImagePlaceholder extends StatelessWidget {
  final double diameter;
  final Color backgroundColor;

  const ProfileImagePlaceholder({Key? key, required this.diameter, this.backgroundColor = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      radius: diameter,
      child: Icon(
        Icons.person_outline,
        color: Theme.of(context).colorScheme.primary,
        size: diameter - 10
      ),
    );
  }
}