import 'package:flutter/material.dart';

class BusinessCard<T> extends StatelessWidget {
  final T item;
  final Widget Function(T) contentBuilder;
  final VoidCallback? onTap;

  const BusinessCard({
    super.key,
    required this.item,
    required this.contentBuilder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: contentBuilder(item),
        ),
      ),
    );
  }
}
