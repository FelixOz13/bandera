import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../components/social_media_icons.dart';
import '../components/play_buttons.dart';
import '../components/image_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:social_media_flutter/social_media_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class VideoScreen extends StatefulWidget {
  final String id;

  const VideoScreen({required this.id});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final Random _random = Random();

  final Map<String, String> _imageUrls = {
    'images/caliente.jpg': 'https://www.caliente.mx/',
    'images/donRamon.jpeg': 'https://www.casadonramon.com/?lang=es/',
    'images/chapulogo.png': 'https://cerveceriachapultepec.com/',
    'images/elektra.png': 'https://www.elektra.mx/',
    'images/ticketmaster.jpg': 'https://www.ticketmaster.com.mx/',
    'images/bancoazteca.jpeg': 'https://www.bancoazteca.com.mx/',
    'images/qin.jpg': 'https://www.qin.mx/',
    'images/akron.jpg':
        'https://www.ticketmaster.com.mx/estadio-akron-boletos-zapopan/venue/500700',
    'images/telmex.png': 'https://telmex.com/',
    'images/tecate.jpg': 'https://tecate.com/',
    'images/tradicional.png': 'https://cuervo.com.mx/es/brands/tequila/jose-cuervo-tradicional/',
    'images/teatrodiana.png': 'https://www.teatrodiana.com/',
    'images/gnp.jpg': 'https://www.gnp.com.mx/',
    'images/mutuo.png': 'https://mutuo.mx/',
    'images/oui.png': 'https://oui-restaurant.netlify.app/',
    'images/minerva.png': 'https://www.cervezaminerva.mx/',
    'images/movistar.png': 'https://tienda.movistar.com.mx/',
    'images/okuma.png': 'https://okuma.com.mx/',
    'images/informador.jpg': 'https://www.informador.mx/',
    'images/rappi.png': 'https://www.rappi.com.mx/',
    'images/auditorio-telmex.jpg': 'https://www.auditorio-telmex.com/',
    'images/sanmatias.jpg': 'https://www.sanmatias.com/mx/',
    'images/corona.jpg': 'https://cervezacorona.es/',
  };
  late String _currentImagePath;
  late String _currentImageUrl;

  late YoutubePlayerController _controller;
  bool _isFullScreen = false;
  bool _isPlaying = false;

  String _getImageUrl(String imagePath) {
    switch (imagePath) {
      case 'images/caliente.jpg':
        return 'https://www.caliente.mx/';
      case 'images/donRamon.jpeg':
        return 'https://www.casadonramon.com/tequila/?lang=es/';
      case 'images/chapulogo.png':
        return 'https://cerveceriachapultepec.com/';
      case 'images/elektra.png':
        return 'https://www.elektra.mx/';
      case 'images/ticketmaster.jpg':
        return 'https://www.ticketmaster.com.mx/';
      case 'images/bancoazteca.jpeg':
        return 'https://www.bancoazteca.com.mx/';
      case 'images/qin.jpg':
        return 'https://www.qin.mx/';
      case 'images/akron.jpg':
        return 'https://www.ticketmaster.com.mx/estadio-akron-boletos-zapopan/venue/500700';
      case 'images/telmex.png':
        return 'https://telmex.com/';
      case 'images/tecate.jpg':
        return 'https://tecate.com/';
      case 'images/tradicional.png':
        return 'https://cuervo.com.mx/es/brands/tequila/jose-cuervo-tradicional/';
      case 'images/teatrodiana.png':
        return 'https://www.teatrodiana.com/';
      case 'images/gnp.jpg':
        return 'https://www.gnp.com.mx/';
      case 'images/mutuo.png':
        return 'https://mutuo.mx/';
      case 'images/oui.png':
        return 'https://oui-restaurant.netlify.app/';
      case 'images/minerva.png':
        return 'https://www.cervezaminerva.mx/';
      case 'images/movistar.png':
        return 'https://tienda.movistar.com.mx/';
      case 'images/okuma.png':
        return 'https://okuma.com.mx/';
      case 'images/informador.jpg':
        return 'https://www.informador.mx/';
      case 'images/rappi.png':
        return 'https://www.rappi.com.mx/';
      case 'images/auditorio-telmex.jpg':
        return 'https://www.auditorio-telmex.com/';
      case 'images/sanmatias.jpg':
        return 'https://www.sanmatias.com/mx/';
      case 'images/corona.jpg':
        return 'https://cervezacorona.es/';
      default:
        throw 'Invalid image path: $imagePath';
    }
  }

  @override
  void initState() {
    super.initState();
    _currentImagePath =
        _imageUrls.keys.elementAt(_random.nextInt(_imageUrls.length));
    _currentImageUrl = _imageUrls[_currentImagePath]!;
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
  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // navigate back to previous screen
          },
        ),
        title: Image.asset(
          'images/mobileregistered.png',
          height: 180,
          width: 180,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/mexback2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 620,
              height: 200,
              child: AspectRatio(
                aspectRatio: 16/9,
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


            SizedBox(height: 3),
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  SizedBox(height: 2),
                  Container(
                    height: 40,
                    child: SocialMediaIcons(),
                  ),
                  SizedBox(height: 16),
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
                  SizedBox(height: 12),
                  Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Patrocinado por:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            height: 150,
                            width: 250,
                            margin: EdgeInsets.only(bottom: 10),
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
                          Container(
                            height: 50,
                            width: 340,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('images/mobileregistered.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // other properties
      bottomNavigationBar: Container(
        height: 60, // set the height to whatever value you need
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () async {
                final url = 'https://banderamusical.com/';
                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
              child: SocialWidget(
                placeholderText: "",
                iconData: Icons.flag_circle,
                iconColor: Colors.red,
                link: '',
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.black, // set the background color here
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Agrega tu Comentario',
                                style: const TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Teko',
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  hintText:
                                      'Proximamente podras Agregar Tus Comentarios Aqui en Esta Seccion '
                                      'Atte. El Compa Felix de Bandera Musical!!!',
                                  hintStyle: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Teko',
                                  ),
                                  // set the text color here
                                  filled: true,
                                  fillColor: Colors.black,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  // set the text color here
                                  labelStyle: TextStyle(color: Colors.white),
                                ),
                                maxLines: 5,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Teko',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(
                Icons.comment,
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
