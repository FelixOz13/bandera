import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String id;

  VideoPlayerScreen({required this.id});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool _isPlaying = false;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        forceHD: true,
        hideControls: false,
      ),
    );
    _controller.addListener(_onPlayerStateChange);
  }

  void _onPlayerStateChange() {
    if (_controller.value.isPlaying != _isPlaying) {
      setState(() {
        _isPlaying = _controller.value.isPlaying;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
      ),
      bottomNavigationBar: PlayButtons(
        isPlaying: _isPlaying,
        onPlayPressed: () {
          setState(() {
            _isPlaying = true;
          });
          _controller.play();
        },
        onPausePressed: () {
          setState(() {
            _isPlaying = false;
          });
          _controller.pause();
        },
      ),
    );
  }
}

class PlayButtons extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPressed;
  final VoidCallback onPausePressed;

  PlayButtons({
    required this.isPlaying,
    required this.onPlayPressed,
    required this.onPausePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.green,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Add padding to the icon button and wrap it in an AnimatedSwitcher widget
          Padding(
            padding: EdgeInsets.only(bottom: 20.0, right: 10.0),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
              // Use a ternary operator to conditionally render the play or pause icon button
              child: isPlaying
                  ? IconButton(
                key: ValueKey(Icons.pause),
                icon: Icon(
                  Icons.pause,
                  color: Colors.pink,
                  size: 50,
                ),
                onPressed: onPausePressed,
              )
                  : IconButton(
                key: ValueKey(Icons.play_arrow),
                icon: Icon(
                  Icons.play_arrow,
                  color: Colors.green,
                  size: 50,
                ),
                onPressed: onPlayPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}