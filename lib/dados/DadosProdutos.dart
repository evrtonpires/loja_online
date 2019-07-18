import 'package:cloud_firestore/cloud_firestore.dart';

class DadosProduto {
  String categoria;
  String id;

  String titulo;
  String descricao;

  double preco;

  List imagens;
  List tamanho;

  DadosProduto.fromDocumentos(DocumentSnapshot snapshot) {
    id = snapshot.documentID;

    descricao = snapshot.data["descricao"];

    imagens = snapshot.data["imagens"];

    preco = snapshot.data["preco"] + .0;

    tamanho = snapshot.data["tamanho"];

    titulo = snapshot.data["titulo"];
  }

  Map<String, dynamic> resumoMap() {
    return {"titulo": titulo, "descricao": descricao, "preco": preco};
  }
}
