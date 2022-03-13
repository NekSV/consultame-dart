import 'package:flutter/material.dart';

class NoSurvey extends StatelessWidget {
  const NoSurvey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text('Actualizar configuración del dispositivo')],
        ),
      ),
    );
  }
}
