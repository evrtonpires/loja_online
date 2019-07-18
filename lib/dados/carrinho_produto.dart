import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/dados/DadosProdutos.dart';


import 'DadosProdutos.dart';

class CarrinhoProduto {


  String cid;

  String categoria;
  String pid;

  int quantidade;

  String tamanho;

  DadosProduto dadosProduto;

  CarrinhoProduto();

  CarrinhoProduto.fromDocument(DocumentSnapshot snapshot) {
    cid = snapshot.documentID;
    categoria = snapshot.data["categoria"];
    pid = snapshot.data["pdi"];
    quantidade = snapshot.data["quantidade"];
    tamanho = snapshot.data["tamanho"];
  }

  Map<String, dynamic> toMap() {
    return {
      "categoria": categoria,
      "pid": pid,
      "quantidade": quantidade,
      "tamanho": tamanho,
      "produto" : dadosProduto.resumoMap()
    };
  }
}
