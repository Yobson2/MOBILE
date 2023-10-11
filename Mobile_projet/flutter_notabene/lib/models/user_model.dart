import 'package:shared_preferences/shared_preferences.dart';

class User {
  String? id_session;
  int id_utilisateur;
  String nom_utilisateur;
  String adresse_email;
  String mot_de_passe;

  User({
    this.id_session, 
    required this.id_utilisateur,
    required this.nom_utilisateur,
    required this.adresse_email,
    required this.mot_de_passe,
  });

  // Méthode pour créer un utilisateur à partir de données par défaut
  factory User.createDefault() {
    return User(
      id_session: "id_session",
      id_utilisateur: 0, 
      nom_utilisateur: 'Utilisateur par défaut',
      adresse_email: 'default@example.com',
      mot_de_passe: 'motdepassepardefaut',
    );
  }

  // Méthode pour créer un utilisateur à partir des données du serveur
  factory User.fromServerData(Map<String, dynamic> data) {
    return User(
      id_utilisateur: data['id_utilisateur'],
      nom_utilisateur: data['nom_utilisateur'],
      adresse_email: data['adresse_email'],
      mot_de_passe: data['mot_de_passe'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_utilisateur': id_utilisateur,
      'nom_utilisateur': nom_utilisateur,
      'adresse_email': adresse_email,
      'mot_de_passe': mot_de_passe,
    };
  }

  Future<int?> getUserIdFromLocalStorage(int? id) async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('user_id');
    return id;
  }
  
}
