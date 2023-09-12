
class  PhotosService {
  int idPhotos;
  int idUtilisateur;
  int idLocalisation;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

   PhotosService({
    required this.idPhotos,
    required this.idUtilisateur,
    required this.idLocalisation,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory  PhotosService.fromJson(Map<String, dynamic> json) {
    return  PhotosService(
      idPhotos: json['id_photos'],
      idUtilisateur: json['id_utilisateur'],
      idLocalisation: json['id_Localisation'],
      image: json['image'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_photos': idPhotos,
      'id_utilisateur': idUtilisateur,
      'id_Localisation': idLocalisation,
      'image': image,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
