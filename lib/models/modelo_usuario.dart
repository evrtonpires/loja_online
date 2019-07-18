import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ModeloUsuario extends Model {
  bool isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userDados = Map();

  static ModeloUsuario of(BuildContext context) {
    return ScopedModel.of<ModeloUsuario>(context);
  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  //usuario atual
  void signUp(
      {@required Map<String, dynamic> userDados,
      @required String senha,
      @required VoidCallback onSucess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userDados["email"], password: senha)
        .then((user) async {
      firebaseUser = user;

      await _saveUserData(userDados);

      onSucess();
      isLoading = false;

      notifyListeners();
    }).catchError((error) {
      onFail();
      isLoading = false;

      notifyListeners();
    });
  }

  void signIn(
      {@required String email,
      @required String senha,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();
    _auth
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((user) async {
      firebaseUser = user;
      await _loadCurrentUser();
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signOut() async {
    await _auth.signOut();

    userDados = Map();

    firebaseUser = null;

    notifyListeners();
  }

  void recuperarSenha(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userDados) async {
    this.userDados = userDados;
    await Firestore.instance
        .collection("usuarios")
        .document(firebaseUser.uid)
        .setData(userDados);
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) {
      firebaseUser = await _auth.currentUser();
    }
    if (firebaseUser != null) {
      if (userDados["nome"] == null) {
        DocumentSnapshot docuser = await Firestore.instance
            .collection("usuarios")
            .document(firebaseUser.uid)
            .get();
        userDados = docuser.data;
      }
    }
    notifyListeners();
  }
}
