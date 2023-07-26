import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
    Function(bool success, String error) callback, // Updated callback function
  ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Registration success
      callback(true, '');
    } catch (e) {
      String errorMessage = _getErrorMessage(e);
      // Registration failed
      callback(false, errorMessage);
    }
  }

  // Helper method to get error message
  String _getErrorMessage(dynamic e) {
    // Add custom error message handling based on different error codes, if needed.
    // For now, we'll simply return the error message as a string.
    return e.toString();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // ... Other methods ...

  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // Google Sign-In canceled by user
        return null;
      }

      // Obtain the GoogleSignInAuthentication object
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential using the GoogleSignInAuthentication object
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      // Return the user from the UserCredential object
      return authResult.user;
    } catch (e) {
      // Handle any errors that occur during the Google Sign-In process
      print('Google Sign-In Error: $e');
      return null;
    }
  }

  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      // Sign in the user with email and password
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Return the user from the UserCredential object
      return authResult.user;
    } catch (e) {
      // Handle any errors that occur during the login process
      print('Login Error: $e');
      return null;
    }
  }
}
