import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:social_media_flutter/social_media_flutter.dart';
import 'comment_box.dart';
import 'package:bandera/screens/shopping_screen.dart';
import 'package:bandera/screens/home_screen.dart';
import 'package:bandera/pages/account_page.dart';
import 'package:bandera/components/custom_bottom_navigation_bar.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({Key? key}) : super(key: key);

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ' 🎸 Bandera Musical 🎸 ',
          style: TextStyle(
            fontFamily: 'Gajraj',
            fontSize: 22.0,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.flag_circle, size: 43, color: Colors.white),
            tooltip: 'Go to initial URL',
            onPressed: () {
              controller.loadUrl('https://banderamusical.com/');
            },
          ),
        ],
       backgroundColor: Colors.black,
  iconTheme: IconThemeData(
    color: Colors.white, // Set the back arrow color to white
  ),
),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        userAgent: 'CustomUserAgent/1.0; no-cache',
        initialUrl: 'https://banderamusical.com/',
        onWebViewCreated: (WebViewController controller) {
          this.controller = controller;
        },
        onPageStarted: (String url) {
          print('Bandera Musical: $url');
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.import_export,
          size: 43,
          color: Colors.white
        ),
        onPressed: () async {
          if (await controller.canGoBack()) {
            controller.goBack();
          } else {
            // If the WebView cannot go back, show an alert dialog
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text('Ya no se puede regresar mas'),
                content: Text('Ya no se puede regresar mas la pagina.'),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
