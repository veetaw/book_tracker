import 'package:book_tracker/screens/book_details/book_details.dart';
import 'package:book_tracker/screens/home/components/book_card.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import '../../../blocs/blocs.dart' show SearchBloc;
import '../../../components/builders/builders.dart' show CustomStreamBuilder;
import '../../../components/builders/custom_future_builder.dart';
import '../../../models/book.dart';
import '../../../models/search.dart';
import '../../../services/google_book_api.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () => showSearch(
        context: context,
        delegate: CustomSearchDelegate(),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final SearchBloc searchBloc = SearchBloc();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context)
        .copyWith(primaryColor: Theme.of(context).scaffoldBackgroundColor);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchBloc.addSearch(query);

    final GoogleBookApi api = GoogleBookApi();

    final mediaQuery = MediaQuery.of(context);

    return query.length > 3
        ? CustomFutureBuilder<List<Book>>(
            future: api.search(query),
            onLoading: () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.height / 2,
                  child: FlareActor(
                    "assets/bookshelf.flr",
                    alignment: Alignment.center,
                    animation: "bookshelf",
                  ),
                ),
                Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ), // TODO: translation
              ],
            ),
            builder: (context, books) {
              return ListView.builder(
                itemCount: books?.length ?? 0,
                padding: EdgeInsets.only(top: 16),
                itemBuilder: (context, index) => BookCard(
                  book: books[index],
                  progress: null,
                  onTap: (book) => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BookDetails(
                        book: book,
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : Text("too short"); // TODO: translation
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchBloc.updateSink(query);

    return CustomStreamBuilder<List<Search>>(
      stream: searchBloc.search,
      onLoading: () => Container(),
      builder: (context, searchList) {
        searchList = searchList.reversed.toList();
        return ListView.builder(
          itemCount: searchList.length,
          itemBuilder: (_, index) =>
              _buildSuggestion(context, searchList[index]),
        );
      },
    );
  }

  Widget _buildSuggestion(BuildContext context, Search search) => ListTile(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => searchBloc.deleteSearch(search),
        ),
        title: Text(search.text),
        onTap: () => query = search.text,
      );
}
