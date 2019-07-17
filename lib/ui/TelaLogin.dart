import 'package:flutter/material.dart';
import 'package:loja_virtual/models/modelo_usuario.dart';
import 'package:loja_virtual/ui/TelaCadastro.dart';
import 'package:scoped_model/scoped_model.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _senha = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return Cadastro();
                }));
              },
              child: Text(
                "Criar Conta",
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
          ],
        ),
        body: ScopedModelDescendant<ModeloUsuario>(
          builder: (context, child, model) {
            if (model.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[
                    TextFormField(
                      controller: _email,
                      decoration: InputDecoration(hintText: "E-mail"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text.isEmpty || !text.contains("@")) {
                          return "E-mail Inválido.";
                        }
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _senha,
                      decoration: InputDecoration(hintText: "Senha"),
                      obscureText: true,
                      validator: (text) {
                        if (text.isEmpty || text.length < 6) {
                          return "Senha Invalida.";
                        }
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: () {
                          if (_email.text.isEmpty){
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("Insira seu Email para recuperação",
                                textAlign: TextAlign.center,),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),));
                          }
                          else{
                            model.recuperarSenha(_email.text);
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("Confira seu Email",
                                textAlign: TextAlign.center,),
                              backgroundColor: Theme.of(context).primaryColor,
                              duration: Duration(seconds: 2),));
                          }
                        },
                        child: Text(
                          "Esqueci minha senha",
                          textAlign: TextAlign.right,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(
                      height: 50.0,
                      child: RaisedButton(
                        child: Text(
                          "Entrar",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        textColor: Colors.white,
                        color: Theme
                            .of(context)
                            .primaryColor,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {}
                          model.signIn(
                              email: _email.text,
                              senha: _senha.text,
                              onSuccess: _onSucess,
                              onFail: _onFail);
                        },
                      ),
                    )
                  ],
                ));
          },
        ));
  }

  void _onSucess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    if(_senha.text.isNotEmpty){
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Falha ao Entrar!\nVerifique Email e Senha.",
          textAlign: TextAlign.center,),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 4),));
    }
  }
}
