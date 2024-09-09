import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/toast.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  // Connexion avec Google
  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) return await _auth.signInWithPopup(googleProvider);

    // Déclencher le flux d'authentification
    final googleUser = await _googleSignIn.signIn();

    // Obtenir les détails d'autorisation de la demande
    final googleAuth = await googleUser!.authentication;

    // Créer un nouvel identifiant
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Une fois connecté, renvoyer l'identifiant de l'utilisateur
    return await _auth.signInWithCredential(credential);
  }

  // Inscription avec email et mot de passe
  Future<User?> signUpWithEmailAndPassword(String email, String password, String username) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await credential.user?.updateDisplayName(username);
      await credential.user?.reload();
      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'Cette adresse email est déjà utilisée');
      } else {
        showToast(message: 'Une erreur s\'est produite: ${e.code}');
      }
    }
    return null;
  }


  // Connexion avec email et mot de passe
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Email ou mot de passe invalide.');
      } else {
        showToast(message: 'Une erreur s\'est produite: ${e.code}');
      }
    }
    return null;
  }

  // État de l'utilisateur en temps réel
  Stream<User?> get user => _auth.authStateChanges();

  // Déconnexion
  Future<void> signOut() async {
    if (_googleSignIn.currentUser != null) {
      await _googleSignIn.signOut();
    }
    return _auth.signOut();
  }
}