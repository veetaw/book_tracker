import 'package:book_tracker/models/book.dart';
import 'package:book_tracker/screens/book_details/components/bottom_bar.dart';
import 'package:book_tracker/screens/book_details/components/custom_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookDetails extends StatelessWidget {
  final Book book;

  const BookDetails({
    Key key,
    this.book,
  })  : assert(book != null),
        super(key: key);

  static start(BuildContext context, Book book) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BookDetails(book: book),
        ),
      );

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: CustomAppBar(),
      body: _BookDetailsBody(height, book),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class _BookDetailsBody extends StatefulWidget {
  final double height;
  final Book book;

  const _BookDetailsBody([this.height, this.book, Key key]) : super(key: key);

  @override
  __BookDetailsBodyState createState() => __BookDetailsBodyState();
}

class __BookDetailsBodyState extends State<_BookDetailsBody> {
  double _cardHeight = 0.0;

  static const _kCardHeightFactor = 1.6;
  static const _kCardHeightPadding = 30;

  @override
  void initState() {
    super.initState();
    _cardHeight = widget.height -
        widget.height / _kCardHeightFactor +
        _kCardHeightPadding;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    const double _kPaddingFromBottom = 0;
    const double _kPaddingFromTop = 100;
    const double _kCardBorderRadius = 32;
    const double _kContentInternalPadding = 16;

    final book = widget.book;

    _buildBorderRadius({double value = 16}) => BorderRadius.all(
          Radius.circular(value),
        );

    final image = Image.network(
      book.thumbnail,
      height: mediaQuery.size.height / _kCardHeightFactor,
      width: mediaQuery.size.width,
      fit: BoxFit.fill,
    );

    final separatorBar = Center(
      child: Container(
        height: 6,
        width: MediaQuery.of(context).size.width / 5,
        decoration: BoxDecoration(
          borderRadius: _buildBorderRadius(),
          color: Colors.grey[350],
        ),
      ),
    );

    Widget starRow() {
      if (book.averageRating == null)
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (int i = 0; i < 5; i++) Icon(Icons.star_border)
          ],
        );
      int roundedRating = book.averageRating.round();
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (int i = 0; i < roundedRating; i++) Icon(Icons.star),
          for (int i = 0; i < (5 - roundedRating); i++) Icon(Icons.star_border),
        ],
      );
    }

    return Container(
      constraints: BoxConstraints.expand(),
      child: Stack(
        children: <Widget>[
          image,
          Positioned(
            bottom: _kPaddingFromBottom,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                var delta = details.delta.dy * -1;
                var newHeight = _cardHeight + delta;

                final min = mediaQuery.size.height -
                    (mediaQuery.size.height / _kCardHeightFactor) +
                    _kCardHeightPadding;
                final max = mediaQuery.size.height - _kPaddingFromTop;

                if (delta < 0 && newHeight >= min ||
                    delta > 0 && newHeight <= max) {
                  setState(() => _cardHeight = newHeight);
                }
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: _buildBorderRadius(value: _kCardBorderRadius),
                  color: Colors.white, // TODO: color
                ),
                padding: EdgeInsets.only(
                  top: _kContentInternalPadding,
                  left: _kContentInternalPadding,
                  right: _kContentInternalPadding,
                ),
                width: mediaQuery.size.width,
                height: _cardHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    separatorBar,
                    Container(
                      width: mediaQuery.size.width,
                      margin: EdgeInsets.only(top: 32),
                      child: Text(
                        book.title ?? "Title not provided", // TODO: translation
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      book.publishedDate != null
                          ? DateFormat.yMMMMd().format(book.publishedDate)
                          : "date not provided", // TODO: translation
                    ),
                    starRow(),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Text(
                        book.description ??
                            "description not provided", // TODO: translation
                        maxLines: mediaQuery.size.height ~/ 35,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
