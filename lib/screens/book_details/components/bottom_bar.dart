import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final Function onStartReadingTap;
  final Function onCartTap;

  const BottomBar({Key key, this.onStartReadingTap, this.onCartTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    const double _kBarHeight = 50;
    const double _kVerticalPadding = 10;
    final double _kHorizontalPadding = mediaQuery.size.width / 4.5;
    const double _kPaddingBetweenTextAndIcon = 8;
    const IconData _kAddIcon = Icons.add;
    const IconData _kCartIcon = Icons.shopping_cart;

    _buildBorderRadius({double value = 16}) => BorderRadius.all(
          Radius.circular(value),
        );
    final _kBarMargin = EdgeInsets.symmetric(
      vertical: _kVerticalPadding,
      horizontal: _kHorizontalPadding,
    );
    final _kBarDecoration = BoxDecoration(
      color: Colors.indigo, // TODO: color
      borderRadius: _buildBorderRadius(),
    );
    const TextStyle _kTextStyle = TextStyle(
      color: Colors.white, // TODO: color
      fontSize: 17,
    );

    return Container(
      height: _kBarHeight,
      margin: _kBarMargin,
      decoration: _kBarDecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: onStartReadingTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  _kAddIcon,
                  color: Colors.white, // TODO: color
                ),
                Padding(
                  padding: EdgeInsets.only(left: _kPaddingBetweenTextAndIcon),
                ),
                Text(
                  "Start reading", // TODO: translation
                  style: _kTextStyle,
                ),
              ],
            ),
          ),
          VerticalDivider(
            color: Colors.white, // TODO: color
          ),
          InkWell(
            onTap: onCartTap,
            child: Icon(
              _kCartIcon,
              color: Colors.white, // TODO: color
            ),
          ),
        ],
      ),
    );
  }
}
