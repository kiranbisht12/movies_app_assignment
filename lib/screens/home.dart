import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/data/database.dart';
import 'package:movies_app/screens/login.dart';
import 'package:movies_app/services/firebase_services.dart';
import 'package:movies_app/utils/moviesTile.dart';
import '../utils/dialog_box.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _movieTextController = TextEditingController();
  final TextEditingController _directorTextController = TextEditingController();
  File? moviePoster;
  MoviesDataBase db = MoviesDataBase();
  final _myBox = Hive.box('mybox');

  void saveNewMovie() {
    setState(() {
      db.moviesList.add([
        _movieTextController.text,
        _directorTextController.text,
        moviePoster
      ]);
      _movieTextController.clear();
      _directorTextController.clear();
      moviePoster = null;
    });
    db.updateDataBase();
    print(db.moviesList);
    Navigator.of(context).pop();
  }

  void insertMovie() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          onSave: saveNewMovie,
          onCancel: () => Navigator.of(context).pop(),
          movieTextController: _movieTextController,
          directorTextController: _directorTextController,
          moviePoster: moviePoster,
        );
      },
    );
  }

  void deleteMovie(int index) {
    setState(() {
      db.moviesList.removeAt(index);
    });
    db.updateDataBase();
    print(db.moviesList);
  }

  @override
  void initState() {
    if (_myBox.get('mybox') == null) {
      db.createInitialData();
      print(db.moviesList);
    } else {
      db.loadData();
      print(db.moviesList);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.cyan,
        title: const Text(
          "Your Movies",
          style: TextStyle(
            fontSize: 22,
            letterSpacing: 1,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseServices().signOut();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: insertMovie,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.blueGrey,
        ),
      ),
      body: ListView.builder(
        itemCount: db.moviesList.length,
        itemBuilder: (context, index) {
          return MoviesTile(
            movie: db.moviesList[index][0],
            director: db.moviesList[index][1],
            deleteFunction: () => deleteMovie(index),
            moviePoster: moviePoster,
          );
        },
      ),
    );
  }
}
