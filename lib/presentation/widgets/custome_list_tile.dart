import 'package:flutter/material.dart';

Widget customeListTile({
  required BuildContext context,
}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.2,
    width: MediaQuery.of(context).size.width,
    child: Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
          horizontal: MediaQuery.of(context).size.width * 0.02,
        ),
        color: Colors.red,
        child: Row(
          children: [
            Columm(
              children: [
                
              ]
            ),
          ],
        )
      ),
    ),
  );
}
