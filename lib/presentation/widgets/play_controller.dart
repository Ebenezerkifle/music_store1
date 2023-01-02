// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

import '../../logic/page_manager.dart';

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
  late final PageManager _pageManager;

  @override
  void initState() {
    super.initState();
    _pageManager = PageManager();
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

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
        ValueListenableBuilder<ProgressBarState>(
          valueListenable: _pageManager.progressNotifier,
          builder: (_, value, __) {
            return ProgressBar(
              progress: value.current,
              total: value.total,
              buffered: value.buffered,
              thumbColor: Colors.yellow,
              thumbGlowColor: Colors.white,
              baseBarColor: Colors.grey,
              progressBarColor: Colors.yellow,
              timeLabelLocation: TimeLabelLocation.below,
              timeLabelTextStyle: const TextStyle(color: Colors.white),
              timeLabelType: TimeLabelType.totalTime,
              onSeek: _pageManager.seek,
            );
          },
        ),
        ValueListenableBuilder<ButtonState>(
            valueListenable: _pageManager.buttonNotifier,
            builder: (context, value, __) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.repeat_outlined), //shuffle
                    color: Colors.white,
                    iconSize: widget.iconSize * 0.6,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_previous_rounded),
                    color: Colors.white,
                    iconSize: widget.iconSize * 0.8,
                  ),
                  value == ButtonState.paused
                      ? IconButton(
                          onPressed: _pageManager.play,
                          icon: const Icon(Icons.play_circle_outline_sharp),
                          color: Colors.white,
                          iconSize: widget.iconSize,
                        )
                      : value == ButtonState.loading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : IconButton(
                              onPressed: _pageManager.pause,
                              icon: const Icon(
                                  Icons.pause_circle_outline_outlined),
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
                    onPressed: _pageManager.stop,
                    icon: const Icon(Icons.stop_rounded),
                    color: Colors.white,
                    iconSize: widget.iconSize * 0.6,
                  ),
                ],
              );
            }),
      ],
    );
  }
}
