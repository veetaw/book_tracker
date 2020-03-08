import 'dart:convert';

import 'package:book_tracker/screens/home/components/favorite_book_card.dart';
import 'package:book_tracker/screens/home/screens/no_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show BouncingScrollPhysics;

import 'package:book_tracker/models/book.dart';

import 'package:book_tracker/screens/home/components/category_bar.dart';

import 'package:provider/provider.dart';

import 'package:book_tracker/screens/home/components/book_card.dart';

import 'components/search_bar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var book_count = 0; // TODO:
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Builder(
        builder: (context) {
          return ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Favorites", // TODO: translation
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  children: <Widget>[
                    if (book_count == 0) NoBooks(message: "No preferred books"),
                    if (book_count != 0)
                      for (int i = 0; i < 3; i++)
                        Padding(
                          padding:
                              EdgeInsets.only(right: 16, left: i == 0 ? 16 : 0),
                          child: FavoriteBookCard(
                            book: Book.fromJson(
                              json.decode(
                                '''{"kind": "books#volume","id": "mptPJQAACAAJ","etag": "LAPJae4RT44","selfLink": "https://www.googleapis.com/books/v1/volumes/mptPJQAACAAJ","volumeInfo": {"title": "Harry Potter. Cofanetto","authors": ["J. K. Rowling"],"publishedDate": "2007","industryIdentifiers": [{"type": "ISBN_10","identifier": "888451892X"},{"type": "ISBN_13","identifier": "9788884518927"}],"readingModes": {"text": false,"image": false},"pageCount": 3687,"printType": "BOOK","categories": ["Juvenile Fiction"],"averageRating": 5,"ratingsCount": 1,"maturityRating": "NOT_MATURE","allowAnonLogging": false,"contentVersion": "preview-1.0.0","imageLinks": {"smallThumbnail": "http://books.google.com/books/content?id=mptPJQAACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api","thumbnail": "http://books.google.com/books/content?id=mptPJQAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"},"language": "it","previewLink": "http://books.google.it/books?id=mptPJQAACAAJ&dq=harry+potter&hl=&cd=1&source=gbs_api","infoLink": "http://books.google.it/books?id=mptPJQAACAAJ&dq=harry+potter&hl=&source=gbs_api","canonicalVolumeLink": "https://books.google.com/books/about/Harry_Potter_Cofanetto.html?hl=&id=mptPJQAACAAJ"},"saleInfo": {"country": "IT","saleability": "NOT_FOR_SALE","isEbook": false},"accessInfo": {"country": "IT","viewability": "NO_PAGES","embeddable": false,"publicDomain": false,"textToSpeechPermission": "ALLOWED","epub": {"isAvailable": false},"pdf": {"isAvailable": false},"webReaderLink": "http://play.google.com/books/reader?id=mptPJQAACAAJ&hl=&printsec=frontcover&source=gbs_api","accessViewStatus": "NONE","quoteSharingAllowed": false}}''',
                              ),
                            ),
                            onTap: (_) => null,
                            progress: i / 10,
                          ),
                        ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
              ),
              ChangeNotifierProvider(
                create: (context) => CategoryChangeNotifier(),
                child: Builder(builder: (context) {
                  var provider = Provider.of<CategoryChangeNotifier>(
                    context,
                  );
                  var categoryIndex = provider.category;

                  return ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: <Widget>[
                      CategoryBar(
                        activeIndex: categoryIndex,
                        categories: ['Archived', 'Reading', 'Popular'],
                        onTap: (i) => provider.category = i,
                      ),
                      for (int i = 0; i < 10; i++)
                        if (categoryIndex == 0)
                          BookCard(
                            book: Book.fromJson(
                              json.decode(
                                '''{"kind": "books#volume","id": "mptPJQAACAAJ","etag": "LAPJae4RT44","selfLink": "https://www.googleapis.com/books/v1/volumes/mptPJQAACAAJ","volumeInfo": {"title": "Harry Potter. Cofanetto","authors": ["J. K. Rowling"],"publishedDate": "2007","industryIdentifiers": [{"type": "ISBN_10","identifier": "888451892X"},{"type": "ISBN_13","identifier": "9788884518927"}],"readingModes": {"text": false,"image": false},"pageCount": 3687,"printType": "BOOK","categories": ["Juvenile Fiction"],"averageRating": 5,"ratingsCount": 1,"maturityRating": "NOT_MATURE","allowAnonLogging": false,"contentVersion": "preview-1.0.0","imageLinks": {"smallThumbnail": "http://books.google.com/books/content?id=mptPJQAACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api","thumbnail": "http://books.google.com/books/content?id=mptPJQAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"},"language": "it","previewLink": "http://books.google.it/books?id=mptPJQAACAAJ&dq=harry+potter&hl=&cd=1&source=gbs_api","infoLink": "http://books.google.it/books?id=mptPJQAACAAJ&dq=harry+potter&hl=&source=gbs_api","canonicalVolumeLink": "https://books.google.com/books/about/Harry_Potter_Cofanetto.html?hl=&id=mptPJQAACAAJ"},"saleInfo": {"country": "IT","saleability": "NOT_FOR_SALE","isEbook": false},"accessInfo": {"country": "IT","viewability": "NO_PAGES","embeddable": false,"publicDomain": false,"textToSpeechPermission": "ALLOWED","epub": {"isAvailable": false},"pdf": {"isAvailable": false},"webReaderLink": "http://play.google.com/books/reader?id=mptPJQAACAAJ&hl=&printsec=frontcover&source=gbs_api","accessViewStatus": "NONE","quoteSharingAllowed": false}}''',
                              ),
                            ),
                            onTap: print,
                            progress: 0.3,
                          ),
                    ],
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      brightness: Theme.of(context).brightness,
      leading: Padding(
        padding: const EdgeInsets.all(12),
        child: CircleAvatar(
          child: Icon(
            Icons.person,
            size: 18,
            color: Theme.of(context).accentIconTheme.color,
          ),
        ),
      ),
      title: Text("Account name"),
      actionsIconTheme: Theme.of(context).primaryIconTheme,
      iconTheme: Theme.of(context).primaryIconTheme,
      textTheme: Theme.of(context).primaryTextTheme,
      actions: <Widget>[
        SearchBar(),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => null,
        ),
      ],
    );
  }
}

class CategoryChangeNotifier extends ChangeNotifier {
  int _category = 1;

  int get category => _category;

  set category(newCategory) {
    _category = newCategory;
    notifyListeners();
  }
}
