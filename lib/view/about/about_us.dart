import 'package:flutter/material.dart';
import 'package:html_viewer_elite/html_viewer_elite.dart';

class AboutUs extends StatelessWidget {
  final String? data;
  final String? title;
  const AboutUs({super.key,this.data,this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title??"")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Html(data: data)

            ],
          ),
        ),
      ),
    );
  }
}
