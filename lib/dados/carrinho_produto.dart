import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/dados/DadosProdutos.dart';


import 'DadosProdutos.dart';

class CarrinhoProduto {
  CarrinhoProduto();

  String cid;

  String categoria;
  String pid;

  int quantidade;

  String tamanho;

  DadosProduto dadosProduto;

  CarrinhoProduto.fromDocument(DocumentSnapshot document) {
    cid = document.documentID;
    categoria = document.data["categoria"];
    pid = document.data["pdi"];
    quantidade = document.data["quantidade"];
    tamanho = document.data["tamanho"];
  }

  Map<String, dynamic> toMap() {
    return {
      "categoria": categoria,
      "pid": pid,
      "quantidade": quantidade,
      "tamanho": tamanho,
      //"produto" : dadosProduto.resumoMap()
    };
  }
}
