import 'package:flutter/material.dart';
import 'package:bandera/screens/web_view.dart';
import 'package:bandera/screens/comment_box.dart';
import 'package:bandera/screens/shopping_screen.dart';
import 'package:bandera/pages/account_page.dart';
import 'package:social_media_flutter/social_media_flutter.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebViewApp()),
              );
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommentBoxScreen()),
              );
            },
            child: SocialWidget(
              placeholderText: "",
              iconData: Icons.comment,
              iconColor: Colors.yellow,
              link: '',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingScreen()),
              );
            },
            child: SocialWidget(
              placeholderText: "",
              iconData: Icons.shopping_cart,
              iconColor: Colors.green,
              link: '',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountPage()),
              );
            },
            child: SocialWidget(
              placeholderText: "",
              iconData: Icons.person,
              iconColor: Colors.white,
              link: '',
            ),
          ),
        ],
      ),
    );
  }
}
