import 'package:flutter/material.dart';
import 'package:loja_virtual/models/modelo_usuario.dart';
import 'package:scoped_model/scoped_model.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _nomeCompleto = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _endereco = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
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
                      controller: _nomeCompleto,
                      decoration: InputDecoration(hintText: "Nome Completo"),
                      validator: (text) {
                        if (text.isEmpty) {
                          return "Nome Invalido";
                        }
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
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
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _endereco,
                      decoration: InputDecoration(hintText: "Endereço"),
                      validator: (text) {
                        if (text.isEmpty) {
                          return "Endereço Inválido.";
                        }
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(
                      height: 50.0,
                      child: RaisedButton(
                        child: Text(
                          "Criar Conta",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Map<String, dynamic> userDados = {
                              "nome": _nomeCompleto.text,
                              "email": _email.text,
                              "endereco": _endereco.text,
                            };

                            model.signUp(
                                userDados: userDados,
                                senha: _senha.text,
                                onSucess: _onSucess,
                                onFail: _onFail);
                          }
                        },
                      ),
                    )
                  ],
                ));
          },
        ));
  }

  void _onSucess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuario Criado Com Sucersso!"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao Criar Usuario!"),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    ));
  }
}
