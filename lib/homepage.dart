import 'dart:convert';

import 'package:api_integration/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SamplePost> samplePost = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Scrollbar(
                  child: ListView.builder(
                      itemCount: samplePost.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Color.fromARGB(255, 113, 161, 200),
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: Text('${samplePost[index].id}'),
                            title: Text('${samplePost[index].title}'),
                          ),
                        );
                      }),
                );
              } else {
                return Center(child: Text("No Data Found!"));
              }
            }));
  }

  Future<List<SamplePost>> getData() async {
    final responce =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        samplePost.add(SamplePost.fromJson(index));
      }
      return samplePost;
    }
    return samplePost;
  }
}
