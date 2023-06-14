import 'package:dio/dio.dart';
import 'package:dio_lesson/model/Post.dart';
import 'package:flutter/material.dart';

class SendingPage extends StatefulWidget {
  const SendingPage({Key? key}) : super(key: key);

  @override
  State<SendingPage> createState() => _SendingPageState();
}

class _SendingPageState extends State<SendingPage> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  Dio dio = Dio();
  Future<Post>? post;

  Future<Post> sendData(int userId, String title, String body) async {
    var response = await dio.post("https://jsonplaceholder.typicode.com/posts",
        data: {"userId": userId, "title": title, "body": body});
    print(response.data);
    return Post.fromJson(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sending Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: userIdController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "userId"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "title"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: bodyController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "body"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              setState(() {
                post = sendData(int.parse(userIdController.value.text),
                    titleController.value.text, bodyController.value.text);
              });
            },
            child: Text("Send"),
            color: Colors.blue,
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: post,
              builder: (BuildContext context, AsyncSnapshot<Post> snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data?.body??"");
            } else {
              return Text("bosh");
            }
          })
        ],
      ),
    );
  }
}
