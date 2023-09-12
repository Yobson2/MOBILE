import 'package:flutter/material.dart';
import 'package:flutter_notabene2/services/api_service.dart';

class CarteGloblale extends StatelessWidget {
    const CarteGloblale({Key? key}) : super(key: key);
    

    void test(){
        ApiManager("baseUrl").fetchData("dsfd", "message", "messageError");
    }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('carte'),
    );
  }
}
