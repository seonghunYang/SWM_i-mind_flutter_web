import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideoCustomController extends ChangeNotifier {
  VideoPlayerController? _videoPlayerController;
  int videoSeconds = 0;
  bool isReadyVideoPlay = false;

  Future<VideoPlayerController?> initVideoController(String url) async {
    _videoPlayerController = VideoPlayerController.asset(url);
    await _videoPlayerController!.initialize();
    return _videoPlayerController;
  }

  VideoPlayerController? get videoController => _videoPlayerController;

  void disposeVideoController() {
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
    }
  }

  void playingControl() {
    if (_videoPlayerController != null) {
      _videoPlayerController!.value.isPlaying
          ? _videoPlayerController!.pause()
          : _videoPlayerController!.play();
      _videoPlayerController!.seekTo(Duration(minutes: 2));
      notifyListeners();
    }
  }
}
