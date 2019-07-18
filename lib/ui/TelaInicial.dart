import 'package:flutter/material.dart';
import 'package:loja_virtual/abas/AbaCategorias.dart';
import 'package:loja_virtual/abas/AbaInicial.dart';
import 'package:loja_virtual/widgets/BotaoCarrinho.dart';
import 'package:loja_virtual/widgets/CustomDrawer.dart';

class HomeScreen extends StatelessWidget {
  final _controladorPagina = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controladorPagina,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_controladorPagina),
          floatingActionButton: BotaoCarrinho(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Categorias"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_controladorPagina),
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
