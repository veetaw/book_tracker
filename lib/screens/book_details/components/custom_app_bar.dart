import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function onStarTap;

  static const _preferredSize = Size.fromHeight(kToolbarHeight);

  const CustomAppBar({
    Key key,
    this.onStarTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _kPadding = 10;
    const double _kButtomRadius = 12;
    const double _kStarPadding = 6;

    const BorderRadius _buttonBorder = BorderRadius.all(
      Radius.circular(_kButtomRadius),
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(_kPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: _buttonBorder,
              ),
              color: Colors.indigo, // TODO: color
              textColor: Colors.white, // TODO: color
              icon: Icon(Icons.arrow_back),
              onPressed: Navigator.of(context).pop,
              label: Text(
                "back".toUpperCase(), // TODO: translation
              ),
            ),
            InkWell(
              onTap: () => onStarTap(),
              child: Container(
                padding: const EdgeInsets.all(_kStarPadding),
                decoration: BoxDecoration(
                  color: Colors.indigo, // TODO: color
                  borderRadius: _buttonBorder,
                ),
                child: Icon(
                  Icons.star_border,
                  color: Colors.white, // TODO: color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => _preferredSize;
}
