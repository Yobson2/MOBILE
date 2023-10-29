import 'package:flutter/material.dart';

class ProfitModal extends StatefulWidget {
  const ProfitModal({Key? key}) : super(key: key);

  @override
  State<ProfitModal> createState() => _ProfitModalState();
}

class _ProfitModalState extends State<ProfitModal> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController commonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(width: 16),
              const Text(
                "Modifier Profit ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              // Ajoutez ici la logique pour récupérer une photo
            },
            child: Text('Récupérer une Photo'),
          ),

          SizedBox(height: 16),

          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Nom',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 16),

          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 16),

          TextFormField(
            controller: commonController,
            decoration: InputDecoration(
              labelText: 'Champ Commun',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              // Ajoutez ici la logique pour traiter le formulaire
            },
            child: Text('Enregistrer'),
          ),
        ],
      ),
    );
  }
}
