import 'dart:io';
import 'package:flutter/material.dart';

class MoviesTile extends StatelessWidget {
  final String movie;
  final String director;
  File? moviePoster;
  Function()? deleteFunction;

  MoviesTile({
    Key? key,
    required this.movie,
    required this.director,
    required this.moviePoster,
    required this.deleteFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white54,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              color: Colors.blueGrey,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie),
                Text(director),
              ],
            ),
            const Expanded(child: Text(" ")),
            IconButton(
                onPressed: deleteFunction,
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.cyan,
                ),
            ),
          ],
        ),
      ),
    );
  }
}
