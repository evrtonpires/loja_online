import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/dados/DadosProdutos.dart';
import 'package:loja_virtual/dados/carrinho_produto.dart';

class CarrinhoTile extends StatelessWidget {
  final CarrinhoProduto carrinhoProduto;

  CarrinhoTile(this.carrinhoProduto);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {}

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
