import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../domain/entity/faq/faq.dart';

class FaqDetailItem extends StatelessWidget {
  final Faq faq;

  const FaqDetailItem({
    super.key,
    required this.faq
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16.0)
      ),
      child: HtmlWidget(
        faq.content,
        textStyle: const TextStyle(fontSize: 13),
      )
    );
  }
}