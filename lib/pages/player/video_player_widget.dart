import 'package:auto_orientation/auto_orientation.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  // This will contain the URL/asset path which we want to play
  final VideoPlayerController videoPlayerController;

  const VideoPlayerWidget({Key key, this.videoPlayerController})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  Container loadingView = Container(
    constraints: BoxConstraints.expand(),
    color: Colors.black,
    child: Center(
      child: Opacity(
        opacity: 0.8,
        child: SpinKitThreeBounce(
          color: Colors.white,
          size: 20.0,
        ),
      ),
    ),
  );

  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      allowedScreenSleep: false,
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      placeholder: loadingView,
      autoInitialize: true,
      errorBuilder: (BuildContext context, String errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
      routePageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondAnimation, provider) {
        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return VideoScaffold(
              child: Scaffold(
                resizeToAvoidBottomPadding: false,
                body: Container(
                  alignment: Alignment.center,
                  color: Colors.black,
                  child: provider,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }
}

class VideoScaffold extends StatefulWidget {
  const VideoScaffold({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() => _VideoScaffoldState();
}

class _VideoScaffoldState extends State<VideoScaffold> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    AutoOrientation.landscapeMode();
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    AutoOrientation.portraitMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
