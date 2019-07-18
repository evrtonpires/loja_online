import 'package:flutter/material.dart';
import 'package:loja_virtual/abas/AbaCategorias.dart';
import 'package:loja_virtual/abas/AbaInicial.dart';
import 'package:loja_virtual/widgets/BotaoCarrinho.dart';
import 'package:loja_virtual/widgets/CustomDrawer.dart';

class HomeScreen extends StatelessWidget {
  final _ControladorPagina = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _ControladorPagina,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_ControladorPagina),
          floatingActionButton: BotaoCarrinho(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Categorias"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_ControladorPagina),
          body: CategoriasTab(),
          floatingActionButton: BotaoCarrinho(),
        ),
        Container(
          color: Colors.yellow,
        ),
        Container(
          color: Colors.red,
        ),
      ],
    );
  }
}
