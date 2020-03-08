import 'package:book_tracker/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final double progress;
  final Function(Book) onTap;

  const BookCard({
    Key key,
    @required this.book,
    @required this.progress,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    const double padding = 16;
    final double _cardWidth = mediaQuery.size.width - padding * 2;
    final double _cardHeight = isPortrait ? 150 : 200;
    const double _kCardElevation = 8;
    final double _imageWidth = _cardWidth / 3;
    final double _textWidth = _cardWidth - _imageWidth;
    const double _kBookTitleSize = 20;
    const int _kBookTitleMaxLines = 2;
    const double _kBookAuthorsSize = 16;
    const int _kBookAuthorsMaxLines = 2;

    _buildBorderRadius({double value = 16}) => BorderRadius.all(
          Radius.circular(value),
        );

    return InkWell(
      onTap: () => onTap(book),
      child: Container(
        width: _cardWidth,
        height: _cardHeight,
        child: Card(
          elevation: _kCardElevation,
          margin: EdgeInsets.all(padding),
          shape: RoundedRectangleBorder(
            borderRadius: _buildBorderRadius(),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(16),
                ),
                child: Image.network(
                  book.thumbnail,
                  width: _imageWidth,
                  height: _cardHeight,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: _textWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        book.title ?? "Title not provided", // TODO: translation
                        maxLines: _kBookTitleMaxLines,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: _kBookTitleSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        (book.authors ?? ["No author provided"])
                            .join(', '), // TODO: translation
                        maxLines: _kBookAuthorsMaxLines,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: _kBookAuthorsSize,
                        ),
                      ),
                      if (progress != null)
                        Row(
                          children: <Widget>[
                            Container(
                              width: _textWidth / 2,
                              child: RoundedProgressBar(
                                borderRadius: _buildBorderRadius(),
                                height: 10,
                                percent: progress * 100,
                                style: RoundedProgressBarStyle(
                                  backgroundProgress:
                                      Colors.grey[150], // TODO: color
                                  colorProgress: Colors.indigo, // TODO: color
                                  borderWidth: 0,
                                  widthShadow: 0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: padding),
                            ),
                            Text(
                              "${(progress * 100).toStringAsFixed(0)} %",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
