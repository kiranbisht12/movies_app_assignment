import 'package:hive_flutter/hive_flutter.dart';

class MoviesDataBase {
  List moviesList = [];

  final _myBox = Hive.box('mybox');

  void createInitialData() {
    moviesList = [];
  }

  void loadData() {
    moviesList = _myBox.get('mybox');
  }

  // update the database
  void updateDataBase() {
    _myBox.put('mybox', moviesList);
  }
}