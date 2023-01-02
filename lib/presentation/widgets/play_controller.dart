// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

class PlayController extends StatefulWidget {
  double iconSize;
  PlayController({
    Key? key,
    required this.iconSize,
  }) : super(key: key);

  @override
  State<PlayController> createState() => _PlayControllerState();
}

class _PlayControllerState extends State<PlayController> {
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Song title",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textScaleFactor: 1.5,
        ),
        const Text(
          "subtitle of the song",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        const ProgressBar(
          progress: Duration.zero,
          total: Duration(minutes: 5, seconds: 10),
          thumbColor: Colors.yellow,
          thumbGlowColor: Colors.white,
          baseBarColor: Colors.grey,
          progressBarColor: Colors.yellow,
          timeLabelLocation: TimeLabelLocation.below,
          timeLabelTextStyle: TextStyle(color: Colors.white),
          timeLabelType: TimeLabelType.remainingTime,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.loop),
              color: Colors.white,
              iconSize: widget.iconSize * 0.6,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.skip_previous_rounded),
              color: Colors.white,
              iconSize: widget.iconSize * 0.8,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.play_circle_outline_sharp),
              color: Colors.white,
              iconSize: widget.iconSize,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.skip_next_rounded),
              color: Colors.white,
              iconSize: widget.iconSize * 0.8,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.stop_rounded),
              color: Colors.white,
              iconSize: widget.iconSize * 0.6,
            ),
          ],
        ),
      ],
    );
  }
}
