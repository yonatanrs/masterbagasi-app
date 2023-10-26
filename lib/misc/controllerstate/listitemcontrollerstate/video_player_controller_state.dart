import 'package:video_player/video_player.dart';

class VideoPlayerControllerState {
  VideoPlayerController videoPlayerController;

  VideoPlayerControllerState({
    required this.videoPlayerController
  });

  VideoPlayerControllerState copy({
    VideoPlayerController? videoPlayerController
  }) {
    return VideoPlayerControllerState(
      videoPlayerController: videoPlayerController ?? this.videoPlayerController
    );
  }
}