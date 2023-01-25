import 'package:flutter/material.dart';

Widget customeSimpleList({
  required String title,
  required VoidCallback onTap,
  required BuildContext context,
}) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.05,
    padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.03),
    child: Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        IconButton(onPressed: onTap, icon: const Icon(Icons.cancel))
      ],
    ),
  );
}
