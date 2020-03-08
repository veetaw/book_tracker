import 'package:book_tracker/models/book.dart';
import 'package:book_tracker/secret.dart';

import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class GoogleBookApi {
  final Dio _session = Dio()
    ..transformer = FlutterTransformer()
    ..interceptors.add(
      DioCacheManager(CacheConfig(baseUrl: "https://www.googleapis.com/"))
          .interceptor,
    );
  // Google Api Key
  final String apiKey;

  GoogleBookApi([key]) : this.apiKey = key ?? GOOGLE_API_KEY;

  Future<List<Book>> search(String searchTerms) async {
    var rawBooks = await _session.get(
      "https://www.googleapis.com/books/v1/volumes",
      queryParameters: {
        'q': searchTerms,
        'key': apiKey,
      },
      options: buildCacheOptions(
        Duration(days: 31),
      ),
    );

    List<Book> data = [];
    for (Map<String, dynamic> rawBook in rawBooks.data["items"])
      data.add(Book.fromJson(rawBook));
    return data;
  }
}
