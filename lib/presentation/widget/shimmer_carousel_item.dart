import 'package:flutter/material.dart';

class ShimmerCarouselItem extends StatelessWidget {
  const ShimmerCarouselItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.grey,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(16.0)
          ),
        )
      )
    );
  }
}