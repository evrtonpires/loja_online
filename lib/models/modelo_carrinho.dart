import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/dados/carrinho_produto.dart';
import 'package:loja_virtual/models/modelo_usuario.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class ModeloCarrinho extends Model {
  ModeloUsuario usuario;

  List<CarrinhoProduto> produtos = [];

  bool isLoading = false;

  ModeloCarrinho(this.usuario);

  static ModeloCarrinho of(BuildContext context) {
    return ScopedModel.of<ModeloCarrinho>(context);
  }

  void addItemCarrinho(CarrinhoProduto carrinhoProduto) {
    produtos.add(carrinhoProduto);

    Firestore.instance
        .collection("usuarios")
        .document(usuario.firebaseUser.uid)
        .collection("carrinho")
        .add(carrinhoProduto.toMap())
        .then((doc) {
      carrinhoProduto.cid = doc.documentID;
    });
    notifyListeners();
  }

  void removeItemCarrinho(CarrinhoProduto carrinhoProduto) {
    Firestore.instance
        .collection("usuarios")
        .document(usuario.firebaseUser.uid)
        .collection("carrinho")
        .document(carrinhoProduto.cid)
        .delete();
    produtos.remove(carrinhoProduto);
    notifyListeners();
  }
}
