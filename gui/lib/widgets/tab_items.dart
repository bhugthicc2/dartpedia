import 'package:flutter/material.dart';

class TabItems extends StatelessWidget {
  final Widget widget;
  const TabItems({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(16.0), child: widget);
  }
}
