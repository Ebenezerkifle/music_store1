import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mucic_store/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayController extends StatefulWidget {
  final double iconSize;
  final List<SongModel> songDetail;
  final bool isPlaying;
  final int index;
  final int id;
  PlayController({
    Key? key,
    required this.iconSize,
    required this.songDetail,
    required this.isPlaying,
    required this.index,
    required this.id,
  }) : super(key: key);

  @override
  State<PlayController> createState() => _PlayControllerState();
}

class _PlayControllerState extends State<PlayController> {
  final playerController = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    (!widget.isPlaying)
        ? playerController.generatePlayList(widget.songDetail, widget.index)
        : null;
    return Obx(
      () => Column(
        children: [
          Text(
            playerController.songTitle.value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textScaleFactor: 1.5,
          ),
          Text(
            playerController.songSubtitle.value,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          ProgressBar(
            progress: playerController.progress.value,
            total: playerController.totalDuration.value,
            buffered: playerController.bufferedDuration.value,
            thumbColor: Colors.yellow,
            thumbGlowColor: Colors.white,
            baseBarColor: Colors.grey,
            progressBarColor: Colors.yellow,
            timeLabelLocation: TimeLabelLocation.below,
            timeLabelTextStyle: const TextStyle(color: Colors.white),
            timeLabelType: TimeLabelType.totalTime,
            // onSeek: playerController.seek,
          ),
          // : ProgressBar(
          //     progress: Duration.zero,
          //     total: Duration(
          //         microseconds: widget.songDetail[0].duration ?? 0),
          //     buffered: Duration.zero,
          //     thumbColor: Colors.yellow,
          //     thumbGlowColor: Colors.white,
          //     baseBarColor: Colors.grey,
          //     progressBarColor: Colors.yellow,
          //     timeLabelLocation: TimeLabelLocation.below,
          //     timeLabelTextStyle: const TextStyle(color: Colors.white),
          //     timeLabelType: TimeLabelType.totalTime,
          //     // onSeek: playerController.seek,
          //   ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.repeat_outlined), //shuffle
                color: Colors.white,
                iconSize: widget.iconSize * 0.6,
              ),
              IconButton(
                onPressed: playerController.onPreviousButtonclick,
                icon: const Icon(Icons.skip_previous_rounded),
                color: Colors.white,
                iconSize: widget.iconSize * 0.8,
              ),
              (playerController.isPlaying(widget.id))
                  ? IconButton(
                      onPressed: playerController.pause,
                      icon: const Icon(Icons.pause_circle_outline),
                      color: Colors.white,
                      iconSize: widget.iconSize,
                    )
                  : IconButton(
                      onPressed: playerController.play,
                      icon: const Icon(Icons.play_circle_outline_sharp),
                      color: Colors.white,
                      iconSize: widget.iconSize,
                    ),
              IconButton(
                onPressed: playerController.onNextButtonClick,
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
      ),
    );
  }
}
