import 'package:flutter/material.dart';
import 'package:bandera/models/channel_model.dart';
import 'package:bandera/models/video_model.dart';
import 'package:bandera/screens/video_screen.dart';
import 'package:bandera/services/api_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:social_media_flutter/social_media_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Channel? _channel = null;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UC8XAwIHJzLAnq3-s04WCzhw');
    setState(() {
      _channel = channel;
    });
  }

  _buildProfileInfo() {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      height: 100.0,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 8, 82, 10),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.green,
            radius: 30.0,
            backgroundImage: NetworkImage(_channel!.profilePictureUrl),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _channel!.title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Gajraj'),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: const EdgeInsets.all(10.0),
        height: 160.0,
        decoration: const BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.green,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 170.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Text(
                video.title,
                style: const TextStyle(
                    color: Colors.white, fontSize: 12.0, fontFamily: 'Gajraj'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = (await APIService.instance
          ..fetchVideosFromPlaylist(playlistId: _channel!.uploadPlaylistId))
        as List<Video>;

    List<Video> allVideos = _channel!.videos!..addAll(moreVideos);
    setState(() {
      _channel!.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bandera Musical'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/mexback.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: _channel != null
            ? NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollDetails) {
                  if (!_isLoading &&
                      _channel!.videos!.length !=
                          int.parse(_channel!.videoCount) &&
                      scrollDetails.metrics.pixels ==
                          scrollDetails.metrics.maxScrollExtent) {
                    _loadMoreVideos();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: 1 + _channel!.videos!.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return _buildProfileInfo();
                    }
                    Video video = _channel!.videos![index - 1];
                    return _buildVideo(video);
                  },
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor, // Red
                  ),
                ),
              ),
      ),
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
