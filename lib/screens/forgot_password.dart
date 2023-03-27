import 'package:flutter/material.dart';

import '../services/firebase_services.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  late String email;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();

  // resetButton() async{
  //   try{
  //     await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) => {
  //       print("Password reset link sent."),
  //     });
  //   } catch(e) {
  //     print("Password reset error: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 50, 40, 50),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    // height: 40,
                    child: Text(
                      "Enter the email address associated with your account and we'll send you a link to reset your password.",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 60,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black54),
                      autocorrect: false,
                      cursorColor: Colors.black54,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                        hintText: "Enter your Email ID",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black54,
                          size: 18,
                        ),
                        border: UnderlineInputBorder(
                          borderSide:
                          BorderSide(width: 2, style: BorderStyle.solid),
                        ),
                      ),
                      controller: _emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter an Email ID.";
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.~]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return "Please enter valid Email. (For Ex: abc@gmail.com)";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            email = _emailTextController.text;
                          });
                        }
                        // resetButton();
                        FirebaseServices().resetButton(context, email);
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.green.shade400),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      child: const Text(
                        "Send",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
