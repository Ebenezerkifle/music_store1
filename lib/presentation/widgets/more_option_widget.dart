import 'package:flutter/material.dart';

Widget moreOptionWidget({
  required BuildContext context,
}) {
  return Container(
    padding: const EdgeInsets.only(left: 10),
    child: Wrap(children: List.generate(4, (index) => listItem())),
  );
}

Widget listItem() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: const [
      Icon(
        Icons.favorite_outline,
        color: Colors.white,
      ),
      SizedBox(
        width: 20,
      ),
      Text(
        "Add to Favorite",
        textScaleFactor: 1.2,
        style: TextStyle(
          color: Colors.white,
        ),
      )
    ],
  );
}
