import 'package:flutter/material.dart';
import 'package:loja_virtual/dados/DadosProdutos.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:loja_virtual/dados/carrinho_produto.dart';
import 'package:loja_virtual/models/modelo_carrinho.dart';
import 'package:loja_virtual/models/modelo_usuario.dart';
import 'package:loja_virtual/ui/TelaCarrinho.dart';
import 'package:loja_virtual/ui/TelaLogin.dart';

// ignore: must_be_immutable
class TelaProduto extends StatefulWidget {
  DadosProduto dados;

  TelaProduto(this.dados);

  @override
  _TelaProdutoState createState() => _TelaProdutoState(dados);
}

class _TelaProdutoState extends State<TelaProduto> {
  final DadosProduto dados;

  String tamanhoSelecionado;

  _TelaProdutoState(this.dados);

  @override
  Widget build(BuildContext context) {
    final Color corPrimaria = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(dados.titulo),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: dados.imagens.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: corPrimaria,
              autoplay: false,
              autoplayDuration: Duration(seconds: 15),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  dados.titulo,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${dados.preco.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: corPrimaria),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Tamanho",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: dados.tamanho.map((s) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (tamanhoSelecionado == s) {
                              tamanhoSelecionado = null;
                            } else {
                              tamanhoSelecionado = s;
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                  color: s == tamanhoSelecionado
                                      ? corPrimaria
                                      : Colors.grey[500],
                                  width: 3.0)),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(s),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: tamanhoSelecionado != null
                        ? () {
                            if (ModeloUsuario.of(context).isLoggedIn()) {
                              CarrinhoProduto carrinhoProduto =
                                  CarrinhoProduto();
                              carrinhoProduto.tamanho = tamanhoSelecionado;
                              carrinhoProduto.quantidade = 1;
                              carrinhoProduto.pid = dados.id;
                              carrinhoProduto.categoria = dados.categoria;

                              ModeloCarrinho.of(context)
                                  .addItemCarrinho(carrinhoProduto);

                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Carrinho();
                              }));
                            } else {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Login();
                              }));
                            }
                          }
                        : null,
                    color: corPrimaria,
                    textColor: Colors.white,
                    child: Text(
                      ModeloUsuario.of(context).isLoggedIn()
                          ? "Adicionar ao Carrinho"
                          : "Entre para Comprar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Descrição",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  dados.descricao,
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
