// CADAVOS, Kyla G. - IT3R6

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Album View',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyAlbum(),
    );
  }
}

class MyAlbum extends StatefulWidget {
  const MyAlbum({Key? key});

  @override
  State<MyAlbum> createState() => _MyAlbumState();
}

class _MyAlbumState extends State<MyAlbum> {
  List<dynamic>? posts; // Make posts nullable

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  Future<void> getPosts() async { 
    var url = Uri.parse("https://jsonplaceholder.typicode.com/photos");

    var response = await http.get(url);

    setState(() {
      posts = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Album View"),
        backgroundColor: Colors.blue,
      ),
      body: posts != null
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: posts!.length, 
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2.0,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Image.network(
                          posts![index]["url"],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          posts![index]["title"],
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : SizedBox.shrink(),
    );
  }
}
