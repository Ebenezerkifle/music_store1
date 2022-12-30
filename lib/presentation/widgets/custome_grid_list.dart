import 'package:flutter/material.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';

Widget customeGridWidget({
  required BuildContext context,
  required VoidCallback onTap,
  required double height,
  required double width,
  required String title,
  required List<String> smallDetails,
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
              Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/mic.jpg'),
                      fit: BoxFit.fitWidth,
                    ),
                    color: MyColors.primaryColor,
                    shape: BoxShape.rectangle),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
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
              icon: const Icon(
                Icons.play_circle,
              ),
              color: Colors.white,
              iconSize: 40,
            ),
          ],
        ),
      ],
    ),
  );
}
