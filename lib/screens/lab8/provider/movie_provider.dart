import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:lab2_task/screens/lab8/model/movie.dart';

final List<Movie> initialData = List.generate(
  50,
  (index) => Movie(
    title: 'Movie #${index + 1}',
    runTime: '${Random().nextInt(100) + 60} minutes',
  ),
);

class MovieProvider with ChangeNotifier {
  final List<Movie> _movies = initialData;
  final List<Movie> _myList = [];
  List<Movie> get movies => _movies;
  List<Movie> get myList => _myList;

  void addToList(Movie movie) {
    _myList.add(movie);
    notifyListeners();
  }

  void removeFromList(Movie movie) {
    _myList.remove(movie);
    notifyListeners();
  }
}
