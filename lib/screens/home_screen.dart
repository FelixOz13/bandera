import 'package:flutter/material.dart';
import 'package:bandera/models/channel_model.dart';
import 'package:bandera/models/video_model.dart';
import 'package:bandera/screens/video_screen.dart';
import 'package:bandera/services/api_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bandera/components/custom_bottom_navigation_bar.dart';

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
          builder: (_) => VideoScreen(id: video.id, title: video.title),
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
        title: const Text(
          ' 🎸 Bandera Musical 🎸 ',
          style: TextStyle(color: Colors.white, fontFamily:'Gajraj'),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back arrow color to white
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
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
