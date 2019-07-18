import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/TelaCategorias.dart';

class CategoriaTile extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  CategoriaTile(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(documentSnapshot.data["icone"]),
      ),
      title: Text(documentSnapshot.data["titulo"]),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return TelaCategoria(documentSnapshot);
        }));
      },
    );
  }
}
