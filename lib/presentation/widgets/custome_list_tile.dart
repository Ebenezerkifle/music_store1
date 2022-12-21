import 'package:flutter/material.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';

Widget customeListTile({
  required BuildContext context,
}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.12,
    width: MediaQuery.of(context).size.width,
    child: Card(
      elevation: 1,
      //shadowColor: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.005,
          horizontal: MediaQuery.of(context).size.width * 0.01,
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
                      color: myYellow,
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
                  children: [
                    const Text(
                      "The Title of the Song",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    const Text(
                      "Sub title of the song...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "5:20",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
