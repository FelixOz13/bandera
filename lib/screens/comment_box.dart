import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';

class CommentBoxScreen extends StatefulWidget {
  @override
  _CommentBoxScreenState createState() => _CommentBoxScreenState();
}

class _CommentBoxScreenState extends State<CommentBoxScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [
    {
      'name': 'Felix The Cat',
      'pic': 'images/banderalogo.jpeg',
      'message': 'I love to code',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggie Smalls',
      'pic': 'https://banderamusical.com/images/Biggie.jpg',
      'message': 'You mean I can post videos and sell merchandise on here?',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Vicente Fernandez',
      'pic': 'https://banderamusical.com/images/VicenteFernandez.jpg',
      'message': 'Esta Chingon',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Ozzy Osbourne',
      'pic': 'images/banderalogo.jpeg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
  ];

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Commentario Recibido");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CommentBox.commentImageParser(
                          imageURLorPath: data[i]['pic'])),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontFamily:'Teko', fontSize:25),
              ),
           subtitle: Text(
                data[i]['message'],
                style: TextStyle(
                  color: Colors.green,fontWeight: FontWeight.bold, fontFamily:'Teko', fontSize:20 // Set text color to yellow
                ),
              ),
              trailing: Text(data[i]['date'], style: TextStyle(
                  color: Colors.red,fontWeight: FontWeight.bold, fontFamily:'Teko', fontSize:20 // Set text color to yellow
                ),),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
  appBar: AppBar(
    title: Text(" 🎸 Commentarios 🎸 ",
     style: TextStyle(color: Colors.white, fontFamily:'Gajraj'),
    ),
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
     iconTheme: IconThemeData(
    color: Colors.white, // Set the back arrow color to white
  ), // Set text color to white
    
  ),
   body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/universalbackground.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5), // Optional: Add a semi-transparent overlay
          ),
          Container(
            child: CommentBox(
              userImage: CommentBox.commentImageParser(
                  imageURLorPath: "images/banderalogo.jpeg"),
              child: commentChild(filedata),
              labelText: 'Escribe un Comentario...',
              errorText: 'El comentario no puede estar vacío',
              withBorder: true,
              sendButtonMethod: () {
                if (formKey.currentState!.validate()) {
                  print(commentController.text);
                  setState(() {
                    var value = {
                      'name': 'El Usuario Nuevo',
                      'pic': 'images/banderalogo.jpeg',
                      'message': commentController.text,
                      'date': '2024-03-13 12:00:00'
                    };
                    filedata.insert(0, value);
                  });
                  commentController.clear();
                  FocusScope.of(context).unfocus();
                } else {
                  print("Not validated");
                }
              },
              formKey: formKey,
              commentController: commentController,
              backgroundColor: Colors.black ,// Optional: Adjust opacity for better contrast
              textColor: Colors.yellow,
              sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.yellow),
            ),
            
          ),
        ],
      ),
    );
  }
}
