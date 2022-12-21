import 'package:flutter/material.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';

Widget customeListTile({
  required BuildContext context,
}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.2,
    width: MediaQuery.of(context).size.width,
    child: Card(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01,
          horizontal: MediaQuery.of(context).size.width * 0.02,
        ),
        color: darkColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.height * 0.15,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.play_arrow_sharp,
                      ),
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "The Title of The song",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text("sub title of the song...")
                  ],
                )
              ],
            ),
            Row(
              children: [
                const Text("5:20"),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
