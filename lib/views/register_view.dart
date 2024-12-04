import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register page'),
        backgroundColor: Color.fromARGB(255, 16, 219, 30),
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.done:
                // TODO: Handle this case.
                return Column(
              children: [
                TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'enter email'),
                ),
                TextField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(hintText: 'enter password'),
                ),
                TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try{
                        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                        print("user registered successfully");
                      }
                      on FirebaseAuthException catch(e){
                        if(e.code == 'weak-password'){
                          print("password too weak, plz change it");
                        }
                        else if(e.code == 'email-already-in-use'){
                          print("this email is already registered");
                        }
                        else if(e.code == 'invalid-email'){
                          print("this email is invalid");
                        }
                      }
                      
                      // print(userCredential);
                    },
                    child: const Text('Register')),
              ],
            );
                // break;
              default:
              return const Text("Loading...");
            }
            
          }),
    );
  }
}