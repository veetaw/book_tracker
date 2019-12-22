import 'package:intl/intl.dart';

class Book {
  final String title;

  final List authors;

  final DateTime publishedDate;

  final String description;

  final int pageCount;

  final List categories;

  final num averageRating;

  final num ratingsCount;

  final String thumbnail;

  Book({
    this.title,
    this.authors,
    this.description,
    this.publishedDate,
    this.pageCount,
    this.categories,
    this.averageRating,
    this.ratingsCount,
    this.thumbnail,
  });

  Book.fromJson(Map json)
      : title = json["volumeInfo"]["title"],
        authors = json["volumeInfo"]["authors"],
        description = json["volumeInfo"]["description"],
        publishedDate = json["volumeInfo"]["publishedDate"] == null
            ? null
            : DateFormat('yyyy').parse(json["volumeInfo"]["publishedDate"]),
        pageCount = json["volumeInfo"]["pageCount"],
        categories = json["volumeInfo"]["categories"],
        averageRating = json["volumeInfo"]["averageRating"],
        ratingsCount = json["volumeInfo"]["ratingsCount"],
        thumbnail = json["volumeInfo"]["imageLinks"]["thumbnail"];
}
