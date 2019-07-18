import 'package:flutter/material.dart';
import 'package:loja_virtual/models/modelo_usuario.dart';
import 'package:loja_virtual/tiles/Drawer_Tiles.dart';
import 'package:loja_virtual/ui/TelaLogin.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController ControladorPagina;

  CustomDrawer(this.ControladorPagina);

  @override
  Widget build(BuildContext context) {
    Widget _BuildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 255, 192, 203), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _BuildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "Flutter's\nClhothing",
                        style: TextStyle(
                            fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        child: ScopedModelDescendant<ModeloUsuario>(
                          builder: (context, child, model) {
                            // print(model.isLoggedIn());
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Olá ${!model.isLoggedIn() ? "" : model.userDados["nome"]}",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (!model.isLoggedIn()) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return Login();
                                      }));
                                    } else {
                                      model.signOut();
                                    }
                                  },
                                  child: Text(
                                    !model.isLoggedIn()
                                        ? "Entre ou Cadastre-se"
                                        : "Sair",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            );
                          },
                        )),
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Inicio", ControladorPagina, 0),
              DrawerTile(Icons.list, "Produtos", ControladorPagina, 1),
              DrawerTile(Icons.location_on, "Lojas", ControladorPagina, 2),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos",
                  ControladorPagina, 3),
            ],
          ),
        ],
      ),
    );
  }
}
