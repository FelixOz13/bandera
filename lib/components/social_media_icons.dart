import 'package:flutter/material.dart';
import 'package:social_media_flutter/social_media_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
      decoration:BoxDecoration(
        color:Colors.black,
        borderRadius:BorderRadius.circular(10.0),

      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  final url = 'https://www.instagram.com/banderamusical/';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
                child: SocialWidget(
                  placeholderText: "",
                  iconData: SocialIconsFlutter.instagram,
                  iconColor: Colors.pink,
                  link: '',
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final url = 'https://twitter.com/BanderaMusical';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
                child: SocialWidget(
                  placeholderText: "",
                  iconData: SocialIconsFlutter.twitter,
                  iconColor: Colors.lightBlue,
                  link: '',
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final url =
                      'https://www.youtube.com/channel/UC8XAwIHJzLAnq3-s04WCzhw';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
                child: SocialWidget(
                  placeholderText: "",
                  iconData: SocialIconsFlutter.youtube,
                  iconColor: Colors.red,
                  link: '',
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final url = 'https://www.tiktok.com/@bandera_musical';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
                child: SocialWidget(
                  placeholderText: "",
                  iconData: Icons.tiktok,
                  iconColor: Colors.white,
                  link: '',
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final url = 'https://music.apple.com/us/browse';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
                child: SocialWidget(
                  placeholderText: "",
                  iconData: SocialIconsFlutter.apple,
                  iconColor: Colors.grey,
                  link: '',
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final url =
                      'https://www.facebook.com/profile.php?id=100087385321347&sk=about';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
                child: SocialWidget(
                  placeholderText: "",
                  iconData: SocialIconsFlutter.facebook_box,
                  iconColor: Colors.blue,
                  link: '',
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final url = 'https://open.spotify.com/';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
                child: SocialWidget(
                  placeholderText: "",
                  iconData: SocialIconsFlutter.spotify,
                  iconColor: Colors.green,
                  link: '',
                ),
              ),
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
            ],
          ),
        ],
      ),
    );
  }
}

