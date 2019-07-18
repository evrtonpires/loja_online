import 'package:flutter/material.dart';
import 'package:loja_virtual/dados/DadosProdutos.dart';
import 'package:loja_virtual/ui/TelaProdutos.dart';

class ProdutoTile extends StatelessWidget {
  final String tipo;
  final dadosProduto dados;

  ProdutoTile(this.tipo, this.dados);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context){
            return TelaProduto(dados);
          })
        );
      },
      child: Card(
        elevation: 5.0,
        child: tipo == "grid"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      dados.imagens[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          dados.titulo,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "R\$ ${dados.preco.toStringAsPrecision(4)}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )),
                ],
              )
            : Row(
          children: <Widget>[
            Flexible(flex: 1,
            child:
            Image.network(
              dados.imagens[0],
              fit: BoxFit.cover,
              height: 250.0,
            ),),
            Flexible(flex: 1,
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start ,
                children: <Widget>[
                  Text(
                    dados.titulo,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "R\$ ${dados.preco.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
