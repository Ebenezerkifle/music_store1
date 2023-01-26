import 'package:flutter/material.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';
import 'package:on_audio_query/on_audio_query.dart';

Widget customeGridWidget({
  required BuildContext context,
  required VoidCallback onTap,
  required double height,
  required double width,
  required String title,
  required List<String> smallDetails,
  required bool? playing,
  required int id,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Card(
          color: MyColors.primaryColor,
          elevation: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height,
                width: width,
                child: QueryArtworkWidget(
                  id: id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                            MediaQuery.of(context).size.width * 0.1)),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/mic.jpg'),
                          fit: BoxFit.fitWidth,
                        ),
                        color: MyColors.primaryColor,
                        shape: BoxShape.rectangle),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                    Column(
                      children: List.generate(
                        smallDetails.length,
                        (index) => Text(
                          smallDetails[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white54,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.12,
                height: MediaQuery.of(context).size.width * 0.12,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                )),
            IconButton(
              onPressed: () {},
              icon: Icon(
                playing != null && playing
                    ? Icons.pause_circle
                    : Icons.play_circle,
              ),
              color: playing != null && playing ? Colors.yellow : Colors.white,
              iconSize: 40,
            ),
          ],
        ),
      ],
    ),
  );
}
