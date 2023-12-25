import 'package:flutter/material.dart';

class ComingSoon extends StatelessWidget {
  final String? title;
  const ComingSoon({super.key,this.title});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Coming Soon..",
            style: TextStyle(
              color: Colors.grey
            ),),
          ],
        ),
      ),
    );
  }
}
