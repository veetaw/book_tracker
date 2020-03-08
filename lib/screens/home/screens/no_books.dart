import 'package:flutter/material.dart';

import 'package:flare_flutter/flare_actor.dart';

class NoBooks extends StatelessWidget {
  final String message;

  const NoBooks({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: mediaQuery.size.width,
            height: mediaQuery.size.height / 2,
            child: FlareActor(
              "assets/girl_book.flr",
              alignment: Alignment.center,
              animation: "leafs",
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 15)),
          Text(
            message ?? "No books saved",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ), // TODO: translation
        ],
      ),
    );
  }
}
