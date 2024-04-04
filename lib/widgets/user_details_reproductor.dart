import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VideoPlayerWidget extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? '',
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      ),
      showVideoProgressIndicator: true,
    );
  }
}