import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';
import '../components/social_media_icons.dart';
import '../components/play_buttons.dart';
import '../components/image_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:bandera/components/custom_bottom_navigation_bar.dart';

class VideoScreen extends StatefulWidget {
  final String id;
  final String title;

  const VideoScreen({required this.id, required this.title});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final Random _random = Random();

  final Map<String, String> _imageUrls = {
    'images/caliente.jpg': 'https://www.caliente.mx/',
    // Add other images and URLs here
  };

  late String _currentImagePath;
  late String _currentImageUrl;
  late YoutubePlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _currentImagePath = _imageUrls.keys.elementAt(_random.nextInt(_imageUrls.length));
    _currentImageUrl = _imageUrls[_currentImagePath]!;
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        forceHD: true,
        hideControls: true,
        controlsVisibleAtStart: false,
      ),
    );
    _controller.addListener(_onPlayerStateChange);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void _onPlayerStateChange() {
    if (_controller.value.isPlaying != _isPlaying) {
      setState(() {
        _isPlaying = _controller.value.isPlaying;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // navigate back to previous screen
          },
        ),
        title: Image.asset(
          'images/mobileregi6.jpg',
          height: 280,
          width: 280,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/universalbackground.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 620,
              height: 200,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  bottomActions: [
                    const SizedBox(width: 14.0),
                    CurrentPosition(),
                    const SizedBox(width: 8.0),
                    ProgressBar(isExpanded: true),
                    RemainingDuration(),
                    const SizedBox(width: 14.0),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 0, width: 50),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Gajraj',
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const SizedBox(height: 0),
                  const SizedBox(height: 30, width: 50),
                  Container(
                    height: 80,
                    child: PlayButtons(
                      isPlaying: _isPlaying,
                      onPlayPressed: () {
                        setState(() {
                          _controller.play();
                          _isPlaying = true;
                        });
                      },
                      onPausePressed: () {
                        setState(() {
                          _controller.pause();
                          _isPlaying = false;
                        });
                      },
                    ),
                  ),
                 
                  const SizedBox(height: 0, width: 50),
                  Column(
                    children: [
                      const Text(
                        'Patrocinado por:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 150,
                        width: 270,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () async {
                            if (await canLaunch(_currentImageUrl)) {
                              await launch(_currentImageUrl);
                            } else {
                              throw 'Could not launch $_currentImageUrl';
                            }
                          },
                          child: ImageButton(
                            image: AssetImage(_currentImagePath),
                            onPressed: () async {
                              if (await canLaunch(_currentImageUrl)) {
                                await launch(_currentImageUrl);
                              } else {
                                throw 'Could not launch $_currentImageUrl';
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20, width: 50),
                      Container(
                        height: 50,
                        width: 370,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/mobileregi6.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 80,
                        child: SocialMediaIcons(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
