import 'package:flutter/material.dart';

import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';

import 'package:book_tracker/models/book.dart';

class FavoriteBookCard extends StatelessWidget {
  final double progress;
  final Book book;
  final Function(Book) onTap;

  const FavoriteBookCard({
    Key key,
    @required this.progress,
    @required this.book,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final double _kCardWidth = mediaQuery.size.width / (isPortrait ? 2 : 3);
    final double _kCardHeight = mediaQuery.size.height / (isPortrait ? 2.6 : 1);
    const double _kIndicatorPadding = 10;
    const double _kCardElevation = 8;
    const double _kPaddingBetweenText = 15;
    const double _kBookTitleSize = 24;
    const int _kBookTitleMaxLines = 2;
    const double _kBookAuthorsSize = 22;
    const int _kBookAuthorsMaxLines = 2;
    const double _kIndicatorHeight = 10;

    _buildBorderRadius({double value = 16}) => BorderRadius.all(
          Radius.circular(value),
        );

    _buildSpaceBetween(double value) => Padding(
          padding: EdgeInsets.only(top: value),
        );

    final progressIndicator = Container(
      padding: EdgeInsets.only(bottom: _kIndicatorPadding * 2),
      width: _kCardWidth - _kIndicatorPadding * 2,
      child: RoundedProgressBar(
        borderRadius: _buildBorderRadius(),
        height: _kIndicatorHeight,
        percent: progress * 100,
        style: RoundedProgressBarStyle(
          backgroundProgress: Colors.white, // TODO: color
          colorProgress: Colors.indigo, // TODO: color
          borderWidth: 0,
          widthShadow: 0,
        ),
      ),
    );

    final titleWidget = Container(
      width: _kCardWidth,
      child: Text(
        book.title ?? "Title not provided", // TODO: translation
        maxLines: _kBookTitleMaxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: _kBookTitleSize,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    final authorsWidget = Container(
      width: _kCardWidth,
      child: Text(
        book.authors.join(', '), // TODO: translation
        maxLines: _kBookAuthorsMaxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: _kBookAuthorsSize,
        ),
      ),
    );

    return InkWell(
      onTap: () => onTap(book),
      child: Container(
        width: _kCardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Card(
                  margin: EdgeInsets.zero,
                  elevation: _kCardElevation,
                  shape: RoundedRectangleBorder(
                    borderRadius: _buildBorderRadius(),
                  ),
                  child: ClipRRect(
                    borderRadius: _buildBorderRadius(),
                    child: Image.network(
                      book.thumbnail,
                      fit: BoxFit.fill,
                      height: _kCardHeight,
                      width: _kCardWidth,
                    ),
                  ),
                ),
                progressIndicator,
              ],
            ),
            _buildSpaceBetween(_kPaddingBetweenText),
            titleWidget,
            _buildSpaceBetween(_kPaddingBetweenText / 2),
            authorsWidget,
          ],
        ),
      ),
    );
  }
}
