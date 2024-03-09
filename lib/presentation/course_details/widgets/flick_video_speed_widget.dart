import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';

class FlickVideoSpeedControlWidget extends StatelessWidget {
  final FlickManager flickManager;

  const FlickVideoSpeedControlWidget({super.key, required this.flickManager});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<double>(
      initialValue:
          flickManager.flickVideoManager?.videoPlayerValue?.playbackSpeed ??
              1.0,
      onSelected: (speed) {
        flickManager.flickControlManager?.setPlaybackSpeed(speed);
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 0.5,
          child: Text("0.5x"),
        ),
        const PopupMenuItem(
          value: 1.0,
          child: Text("1x"),
        ),
        const PopupMenuItem(
          value: 1.5,
          child: Text("1.5x"),
        ),
        const PopupMenuItem(
          value: 2.0,
          child: Text("2x"),
        ),
      ],
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.speed,
          size: 35,
          color: Colors.red,
        ),
      ),
    );
  }
}
