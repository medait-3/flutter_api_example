import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {
  List posts = [];

  Future getpost() async {
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    http.Response response = await http.get(uri);
    var responsebody = jsonDecode(response.body);
    print(responsebody[2]);
    setState(() {
      posts.addAll(responsebody);
    });
    print(posts);
  }

  void initState() {
    getpost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('api'),
      ),
      body: posts == null || posts.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, i) {
                return Container(
                    margin: EdgeInsets.only(left: 11),
                    child: Text("${posts[i]['id']}"));
              }),
    );
  }
}
