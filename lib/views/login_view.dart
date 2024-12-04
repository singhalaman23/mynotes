import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: Text('Login page'),
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
                      // FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                      try{
                        final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                        print("logged in successfully");
                      }
                      on FirebaseAuthException catch (e){
                        // print(e.code);
                        if(e.code == 'invalid-credential'){
                          print("Wrong email or password or user not found");
                        }
                        else{
                          print("something else happened");
                          print(e.code);
                        }
                      }
                      // catch(e){
                      //   print("something bad happened");
                      //   print(e.runtimeType);
                      //   print(e);
                      // }
                      
                      // print(userCredential);
                    },
                    child: const Text('Login')),
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