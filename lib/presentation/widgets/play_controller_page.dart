import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../logic/page_manager.dart';
import '../../logic/play_controller/play_controller_bloc.dart';

class PlayController extends StatefulWidget {
  double iconSize;
  SongModel songDetail;
  bool isPlaying;
  PlayController({
    Key? key,
    required this.iconSize,
    required this.songDetail,
    required this.isPlaying,
  }) : super(key: key);

  @override
  State<PlayController> createState() => _PlayControllerState();
}

class _PlayControllerState extends State<PlayController> {
  late final PageManager _pageManager;

  @override
  void initState() {
    super.initState();
    _pageManager = PageManager(url: widget.songDetail.uri ?? "");
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayControllerBloc, PlayControllerState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              widget.songDetail.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 1.5,
            ),
            Text(
              widget.songDetail.displayNameWOExt,
              style: const TextStyle(
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
      },
    );
  }
}
/**
 * 
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayControllerBloc, PlayControllerState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              widget.songDetail.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 1.5,
            ),
            Text(
              widget.songDetail.displayNameWOExt,
              style: const TextStyle(
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
                      IconButton(
                        onPressed: () =>
                            BlocProvider.of<PlayControllerBloc>(context).add(
                                (!widget.isPlaying)
                                    ? PlayEvent(
                                        uri: widget.songDetail.uri ?? '',
                                        index: 0)
                                    : PauseEvent(
                                        uri: widget.songDetail.uri ?? '',
                                      )),
                        icon: const Icon(Icons.play_circle_outline_sharp),
                        color: Colors.white,
                        iconSize: widget.iconSize,
                      ),
                      // : value == ButtonState.loading
                      //     ? const CircularProgressIndicator(
                      //         color: Colors.white,
                      //       )
                      //     : IconButton(
                      //         onPressed: _pageManager.pause,
                      //         icon: const Icon(
                      //             Icons.pause_circle_outline_outlined),
                      //         color: Colors.white,
                      //         iconSize: widget.iconSize,
                      //       ),
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
      },
    );
  }
 * 
 */