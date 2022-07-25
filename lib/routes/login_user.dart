import 'package:data_estructure_dart/Widgets/textField.dart';
import 'package:data_estructure_dart/routes/list.dart';
import 'package:data_estructure_dart/routes/signUp_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final firebaseAuth = FirebaseAuth.instance;
  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,title: const Text("Login")),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          formTextField(hint: "Email",  controller: emailController, passField: false),
          formTextField(hint: "Senha", controller: passController, passField: true),
          ElevatedButton(onPressed: (){login();}, child: const Text("Entrar")),
          TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));}, child: const Text("Criar conta"))
        ],
      ),
    );
  }

  login() async{
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passController.text
      );

      if(userCredential != null){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => TaskList())
        );
      }
    }
    on FirebaseAuthException catch (e) {
      if(e.code == 'invalid-email'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Usuário não encontrado"),
            backgroundColor: Colors.redAccent,
          )
        );
      }else if(e.code == 'wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("senha incorreta"),
            backgroundColor: Colors.redAccent,
          )
        );
      }
    }
  }
}