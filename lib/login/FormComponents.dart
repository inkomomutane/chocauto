import 'package:chocauto/Components/LabelComponent.dart';
import 'package:chocauto/Components/PasswordComponent.dart';
import 'package:chocauto/Components/TextComponent.dart';
import 'package:chocauto/Controllers/AppController.dart';
import 'package:chocauto/HomePage.dart';
import 'package:chocauto/Models/Auth.dart';
import 'package:chocauto/login/Register/RegisterPage.dart';
import 'package:flutter/material.dart';

class FormComponents extends StatefulWidget {
  const FormComponents({Key? key}) : super(key: key);

  @override
  _FormComponentsState createState() => _FormComponentsState();
}

class _FormComponentsState extends State<FormComponents> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? passwordController;
  Map<String, String> session = {"username": "", "password": ""};
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LabelComponent(labelText: "Username"),
            TextComponent(
              hintText: "Username",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Campo Obrigatório";
                } else {
                  return null;
                }
              },
              onChanged: (username) {
                setState(() {
                  session['username'] = username;
                });
              },
              onSaved: (username) {
                setState(() {
                  session['username'] = "$username";
                });
              },
            ),
            LabelComponent(labelText: "Password"),
            PasswordComponent(
              hintText: "Password",
              validator: (password) {
                if (password!.isEmpty || password.length < 8) {
                  return "A senha deve ter no mínimo 8 letras";
                } else {
                  return null;
                }
              },
              controller: passwordController,
              onChanged: (password) {
                setState(() {
                  session['password'] = "$password";
                });
              },
              onSaved: (password) {
                setState(() {
                  session['password'] = "$password";
                });
              },
            ),
            Padding(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 4),
                child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print("${session["email"]} : " +
                            "${session["password"]}");
                        if (AppController.login(Auth(
                            username: "${session["username"]}",
                            password: "${session["password"]}"))) {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => HomePage(),
                              fullscreenDialog: true,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Usuario não encontrado! por favor contacte a administrador.',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }
                    },
                    child: Text("Entrar"),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber.shade900),
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(22))))),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => RegisterPage(),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: LabelComponent(labelText: 'Registar-se'),
            )
          ],
        ),
      ),
    );
  }
}
