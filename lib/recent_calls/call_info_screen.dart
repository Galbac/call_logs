import 'dart:convert';

import 'package:call_logs/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CallInfo extends StatelessWidget {
  const CallInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orange[300],
        alignment: Alignment.center,
        child: FutureBuilder<http.Response>(
          future: http.get(Uri.parse('https://reqres.in/api/users/5')),
          builder:
              (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
            if (snapshot.hasData) {
              final decoded = jsonDecode(snapshot.data!.body);
              final userInfo = decoded["data"];

              return Column(
                children: [
                  const SizedBox(height: 90),
                  Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: SizedBox(
                      width: 300,
                      height: 350,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                                "https://reqres.in/img/faces/5-image.jpg"),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                userInfo["first_name"].toString(),
                                style: AppTextStyle.regular15(),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                userInfo["last_name"].toString(),
                                style: AppTextStyle.regular15(),
                              ),
                            ],
                          ),
                          Text(userInfo["email"].toString()),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(
      this.userId,
      this.id,
      this.title,
      this.body,
      );
}