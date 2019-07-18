import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/dados/DadosProdutos.dart';

class CarrinhoProduto {

  CarrinhoProduto();

  String cid;

  String categoria;
  String pid;

  int quantidade;

  String tamanho;

  dadosProduto DadosProduto;

  CarrinhoProduto.fromDocument(DocumentSnapshot document){
    cid = document.documentID;
    categoria = document.data["categoria"];
    pid = document.data["pdi"];
    tamanho = document.data["tamanho"];
  }

  Map<String,dynamic> toMap(){
    return {
      "categoria" : categoria,
      "pid" : pid,
      "quantidade" : quantidade,
      "tamanho" : tamanho,
     // "produto" : DadosProduto.resumoMap()
    };
  }
}
