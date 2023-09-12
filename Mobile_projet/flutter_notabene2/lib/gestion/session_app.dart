import '../model/user_app.dart';

class Session {
  static Session? _instance;
  static Session get instance => _instance ??= Session._();

  Session._();

  User? _currentUser;

  void loginUser(String email, String mot_de_passe) {
    _currentUser = User(name: 'John Doe', email: email, mot_de_passe: mot_de_passe);
  }

  void signUp(String email, String mot_de_passe) {
    _currentUser = User(name: 'John Doe', email: email, mot_de_passe: mot_de_passe);
  }

  void logoutUser() {
    _currentUser = null;
  }

  bool get isLoggedIn => _currentUser != null;

  User? getCurrentUser() {
    return _currentUser;
  }

    // Nouvelle méthode pour vérifier la connectivité Internet
    // Future<bool> isInternetConnected() async {
       
    // }

    //Appelle Api

  Future<String> fetchDataFromApi() async {
    return "Données de l'API";
  }
}
