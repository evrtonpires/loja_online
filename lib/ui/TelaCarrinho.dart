import 'package:flutter/material.dart';
import 'package:loja_virtual/models/modelo_carrinho.dart';
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
              builder: (context,child,model){

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
    );
  }
}
