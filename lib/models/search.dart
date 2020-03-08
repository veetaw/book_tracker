import 'package:meta/meta.dart';

class Search {
  final String text;
  final int index;

  Search({@required this.text, this.index});

  factory Search.fromDatabaseJson(Map<String, dynamic> data) => Search(
        text: data["search"],
        index: data["id"],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "index": index,
        "search": text,
      };
}
