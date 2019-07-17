import 'package:flutter/material.dart';
import 'package:loja_virtual/models/modelo_usuario.dart';
import 'package:loja_virtual/ui/TelaInicial.dart';
import 'package:loja_virtual/ui/TelaLogin.dart';
import 'package:scoped_model/scoped_model.dart';

void main(){
  runApp(new LojaVirtual());
}

class LojaVirtual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ModeloUsuario>(
      model: ModeloUsuario(),
      child: MaterialApp(
          title: "Loja Virtual",
          theme: ThemeData(
            primarySwatch: Colors.teal,
            primaryColor: Color.fromARGB(255, 211,118,130),
          ),
          debugShowCheckedModeBanner: false,
          home: HomeScreen()
      ),
    );
  }
}
