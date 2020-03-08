import 'package:intl/intl.dart';

class Book {
  final String id;

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
    this.id,
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

  Book.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["volumeInfo"]["title"],
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

  Book.fromDatabaseJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        authors = (json["authors"] as String).split("|"),
        publishedDate =
            DateTime.fromMillisecondsSinceEpoch(json["publishedDateTimestamp"]),
        description = json["description"],
        pageCount = json["pageCount"],
        averageRating = json["averageRating"],
        categories = (json["categories"] as String).split("|"),
        ratingsCount = json["ratingsCount"],
        thumbnail = json["text"];

  Map<String, dynamic> toDatabaseJson() {
    return {
      "id": id,
      "title": title,
      "authors": authors ?? [].join("|"),
      "publishedDateTimestamp": publishedDate?.millisecondsSinceEpoch ?? 0,
      "description": description,
      "pageCount": pageCount,
      "averageRating": averageRating,
      "categories": categories ?? [].join("|"),
      "ratingsCount": ratingsCount,
      "thumbnail": thumbnail,
    };
  }
}
