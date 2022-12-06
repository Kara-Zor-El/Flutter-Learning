import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final usernameCntrl = TextEditingController();
    final passwordCntrl = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown,
        title: const Text("Welcome!"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height / 8),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    size.width * 0.1, size.height / 10, size.width * 0.1, 0),
                child: TextField(
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Username',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  ),
                  controller: usernameCntrl,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    size.width * 0.1, size.height / 9, size.width * 0.1, 0),
                child: TextField(
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  ),
                  controller: passwordCntrl,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    size.width * 0.1, size.height / 8, size.width * 0.1, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width / 10,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Back"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width / 10,
                        ),
                      ),
                      onPressed: () => print('e'),
                      child: const Text("Make Account"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
