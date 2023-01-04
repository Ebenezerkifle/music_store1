import 'package:flutter/material.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';

Widget customeListTile({
  required String title,
  required BuildContext context,
  required VoidCallback onTap,
  required List<String>? smallDetails,
  Color? color,
  required bool playing,
  int? duration,
  required VoidCallback onPlayTap,
}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.11,
    child: GestureDetector(
      onTap: onTap,
      child: Card(
        color: color ?? Colors.white,
        shadowColor: MyColors.bright2,
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.04,
                      backgroundColor: Colors.transparent,
                      backgroundImage: const AssetImage(
                        'assets/images/mic.jpg',
                      ),
                    ),
                    IconButton(
                      onPressed: onPlayTap,
                      icon: Icon(playing
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded),
                      color: playing ? Colors.yellow : Colors.white,
                      iconSize: 38,
                    )
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        textScaleFactor: 1.2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (color != null) ? Colors.white : Colors.black,
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            smallDetails!.length,
                            (index) => Text(
                              smallDetails[index],
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text("5:13",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          )),
                      Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
