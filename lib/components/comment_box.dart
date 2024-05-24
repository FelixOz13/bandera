import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: CommentBox(),
      ),
    );
  }
}

class CommentBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 16),
                    Text('Add a comment', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Type your comment here',
                      ),
                      maxLines: 5,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Handle form submission
                        Navigator.pop(context);
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        width: 200,
        height: 100,
        color: Colors.green,
        child: Center(child: Text('Leave a comment')),
      ),
    );
  }
}

