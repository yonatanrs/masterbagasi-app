import 'package:flutter/material.dart';

import '../../misc/constant.dart';

class PasswordObscurer extends StatelessWidget {
  final VoidCallback? onObscurePassword;
  final bool obscurePassword;
  final Color? color;

  const PasswordObscurer({
    Key? key,
    this.onObscurePassword,
    required this.obscurePassword,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onObscurePassword,
      child: Icon(
        obscurePassword ? Icons.visibility_off : Icons.visibility,
        color: color ?? Constant.colorPasswordObscurer,
      )
    );
  }
}