import 'package:flutter/material.dart';
import 'package:loja_virtual/models/modelo_carrinho.dart';
import 'package:loja_virtual/models/modelo_usuario.dart';
import 'package:loja_virtual/tiles/CarrinhoTile.dart';
import 'package:loja_virtual/ui/TelaLogin.dart';
import 'package:scoped_model/scoped_model.dart';

class Carrinho extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        centerTitle: true,
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8.0),
            child: ScopedModelDescendant<ModeloCarrinho>(
              builder: (context, child, model) {
                int quantProdtCarrinho = model.produtos.length;

                return Text(
                  "${quantProdtCarrinho ?? 0} ${quantProdtCarrinho == 1 ? "Item" : "Itens"}",
                  style: TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<ModeloCarrinho>(
          builder: (context, child, model) {
        if (model.isLoading && ModeloUsuario.of(context).isLoggedIn()) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!ModeloUsuario.of(context).isLoggedIn()) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.remove_shopping_cart,
                  size: 80.0,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Faça o Login para adicionar Produtos!",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16.0,
                ),
                RaisedButton(
                  child: Text(
                    "Entrar",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Login();
                    }));
                  },
                )
              ],
            ),
          );
        } else if (model.produtos == null || model.produtos.length == 0) {
          return Center(
            child: Text(
              "Nenhum produto no Carrinho!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        }
        else{
          return ListView(
            children: <Widget>[
              Column(
                children: model.produtos.map((produto){
                  return CarrinhoTile(produto);
              }).toList(),
              )
            ],
          );
        }
      }),
    );
  }
}
