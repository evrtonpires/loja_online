import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/dados/DadosProdutos.dart';
import 'package:loja_virtual/dados/carrinho_produto.dart';

class CarrinhoTile extends StatelessWidget {
  final CarrinhoProduto carrinhoProduto;

  CarrinhoTile(this.carrinhoProduto);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            width: 120.0,
            child: Image.network(
              carrinhoProduto.dadosProduto.imagens[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    carrinhoProduto.dadosProduto.titulo,
                    style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                  ),
                  Text(
                    "Tamanho: ${carrinhoProduto.tamanho}",
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                  Text(
                    "R\$ ${carrinhoProduto.dadosProduto.preco.toStringAsFixed(
                        2)}",
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.remove),
                          color: Theme
                              .of(context)
                              .primaryColor,
                          onPressed:
                          carrinhoProduto.quantidade > 1 ? () {} : null),
                      Text(carrinhoProduto.quantidade.toString()),
                      IconButton(
                          icon: Icon(Icons.add),
                          color: Theme
                              .of(context)
                              .primaryColor,
                          onPressed: () {}),
                      FlatButton(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        child: Text("Remover"),
                        textColor: Colors.white,
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: carrinhoProduto.dadosProduto == null
            ? FutureBuilder<DocumentSnapshot>(
                future: Firestore.instance
                    .collection("produtos")
                    .document(carrinhoProduto.categoria)
                    .collection("itens")
                    .document(carrinhoProduto.pid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    carrinhoProduto.dadosProduto =
                        DadosProduto.fromDocumentos(snapshot.data);
                    return _buildContent();
                  } else {
                    return Container(
                      height: 70.0,
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    );
                  }
                },
              )
            : _buildContent());
  }
}
