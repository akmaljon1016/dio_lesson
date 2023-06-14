import 'package:dio/dio.dart';
import 'package:dio_lesson/model/Post.dart';
import 'package:dio_lesson/sending_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Dio dio = Dio();

  Future<List<Post>> loadPosts() async {
    var response = await dio.get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == 200) {
      return listFromJson(response.data);
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dio"),
      ),
      body: FutureBuilder(
          future: loadPosts(),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: Center(
                        child: Text(snapshot.data?[index].title ?? "NULL"),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SendingPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
