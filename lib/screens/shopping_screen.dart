import 'package:flutter/material.dart';
import 'package:social_media_flutter/social_media_flutter.dart';
import 'comment_box.dart';
import 'package:bandera/screens/home_screen.dart';
import 'package:bandera/screens/web_view.dart';
import 'package:bandera/pages/account_page.dart';
import 'package:bandera/components/custom_bottom_navigation_bar.dart';

class ShoppingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' 🎸 Mercancia Oficial 🎸 ',
         style: TextStyle(color: Colors.white, fontFamily:'Gajraj'),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white, // Set text color to white
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "tshirts/universalbackground.jpg",
              fit: BoxFit.cover,
            ),
          ),
          // Grid of T-Shirts
          GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: tShirts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            itemBuilder: (ctx, index) => TShirtItem(
              title: tShirts[index]['title'] ?? 'No Title',
              imageUrl: tShirts[index]['imageUrl'] ?? '/images/universalbackground.jpg',
            ),
          ),
        ],
      ),
     bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class TShirtItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  TShirtItem({
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

final List<Map<String, String>> tShirts = [
  {
    'title': 'Cafe Tacuba',
    'imageUrl': 'tshirts/cafetacuba_tshirt.png',
  },
  {
    'title': 'Caifanes',
    'imageUrl': 'tshirts/caifanes_tshirt.png',
  },
  {
    'title': 'Chalino Sanchez',
    'imageUrl': 'tshirts/chalino_tshirt.png',
  },
  {
    'title': 'Pink Floyd',
    'imageUrl': 'tshirts/pinkfloyd_tshirt.png',
  },
  {
    'title': 'Daft Punk',
    'imageUrl': 'tshirts/daftpunk_tshirt.png',
  },
  {
    'title': 'Motley Crue',
    'imageUrl': 'tshirts/motleycrue_tshirt.png',
  },
];
