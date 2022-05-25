import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: const Text(
            'Result',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
            padding: const EdgeInsets.all(30),
            child: Center(
                child: Column(
              children: [
                Text('The Result is'),
                SizedBox(
                  height: 370,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        child: Text('Try Again'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                          Colors.amber,
                        ))),
                    SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Back to Home'),
                    )
                  ],
                ),
              ],
            ))));
  }
}
