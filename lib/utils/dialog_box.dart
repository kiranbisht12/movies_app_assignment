import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DialogBox extends StatefulWidget {
  final movieTextController;
  final directorTextController;
  File? moviePoster;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {Key? key,
      required this.onSave,
      required this.onCancel,
      required this.moviePoster,
      required this.movieTextController,
      required this.directorTextController})
      : super(key: key);

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  final _formKey = GlobalKey<FormState>();
  File? imageFile;

  Future getImageGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() async {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        print("No image selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: widget.movieTextController,
                decoration: const InputDecoration(
                  hintText: "Movie Name",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter movie name.";
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: widget.directorTextController,
                decoration: const InputDecoration(
                  hintText: "Director Name",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter director name.";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Add Movie Poster",
                    style: TextStyle(color: Colors.black54),
                  ),
                  GestureDetector(
                    onTap: () async {
                      print("tapped");
                      getImageGallery();
                    },
                    child: const Icon(
                      Icons.add_a_photo,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 35,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.cyan),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (imageFile != null) {
                            widget.onSave();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Insert movie poster")));
                          }
                        }
                      },
                      child: const Text("Add"),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 35,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.cyan),
                      ),
                      onPressed: () {
                        widget.movieTextController.clear();
                        widget.directorTextController.clear();
                        imageFile = null;
                        widget.onCancel();
                      },
                      child: const Text("Cancel"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
