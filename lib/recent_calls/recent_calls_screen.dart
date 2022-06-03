import 'dart:convert';

import 'package:call_logs/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:call_logs/recent_calls/call_item.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class RecentCalls extends StatefulWidget {
  const RecentCalls({Key? key}) : super(key: key);

  @override
  State<RecentCalls> createState() => _RecentCallsState();
}

class _RecentCallsState extends State<RecentCalls> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text(
            'Журнал звонков',
            style: TextStyle(color: AppColor.primary),
          ),
          backgroundColor: AppColor.appBar,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColor.appBar,

            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
        // body: ListView.separated(
        //   itemBuilder: (_, int index) => const CallCard(),
        //   separatorBuilder: (_, int index) => const Padding(
        //     padding: EdgeInsets.only(left: 42),
        //     child: Divider(
        //       thickness: 0.5,
        //       height: 0.5,
        //       color: AppColor.tertiary,
        //     ),
        //   ),
        //   itemCount: 300,
        //   physics: const BouncingScrollPhysics(),
        // ),
        body: FutureBuilder<http.Response>(
          future: http.get(Uri.parse("https://reqres.in/api/users")),
          builder:
              (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
            if (snapshot.hasData) {
              final Map<String, dynamic> decode = jsonDecode(snapshot.data!.body);
              final List<dynamic> userList = decode["data"];

              return ListView.separated(
                itemBuilder: (_, int index) {
                  final userInfo = userList[index];

                  return CallCard(
                    phone: userInfo['first_name'],
                    data: userInfo['id'].toString(),
                    information: userInfo["email"],
                  );
                },
                separatorBuilder: (_, int index) => const Padding(
                  padding: EdgeInsets.only(left: 42),
                  child: Divider(
                    thickness: 0.5,
                    height: 0.5,
                    color: AppColor.tertiary,
                  ),
                ),
                itemCount: 6,
                physics: const BouncingScrollPhysics(),
              );
            }else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }
}
