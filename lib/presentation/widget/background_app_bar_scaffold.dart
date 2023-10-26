import 'package:flutter/material.dart';

class BackgroundAppBarScaffold extends StatelessWidget {
  final ImageProvider backgroundAppBarImage;
  final AppBar appBar;
  final Widget body;

  const BackgroundAppBarScaffold({
    super.key,
    required this.backgroundAppBarImage,
    required this.appBar,
    required this.body
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: kToolbarHeight + MediaQuery.of(context).viewPadding.top,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: backgroundAppBarImage,
                fit: BoxFit.cover
              )
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                appBar,
                body
              ]
            )
          ),
        ]
      ),
    );
  }
}