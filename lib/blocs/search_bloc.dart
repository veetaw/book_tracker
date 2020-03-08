import 'dart:async';

import '../bloc/bloc.dart';
import '../database/search_dao.dart';
import '../models/search.dart';

class SearchBloc extends Bloc {
  SearchDao dao = SearchDao();

  final StreamController _controller =
      StreamController<List<Search>>.broadcast();

  get search => _controller.stream;

  SearchBloc() {
    updateSink();
  }

  updateSink([String term]) async =>
      _controller.sink.add(await dao.getAll(term));

  addSearch(String search) async {
    // don't add duplicate search
    List<Search> data = await dao.getAll();
    bool add = true;
    for (Search s in data) if (s.text == search) add = false;
    if (add) await dao.addSearch(Search(text: search));
    updateSink();
  }

  deleteSearch(Search search) async {
    await dao.deleteSearch(search);
    updateSink();
  }

  dispose() {
    _controller.close();
  }
}
