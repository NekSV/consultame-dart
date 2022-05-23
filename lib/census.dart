import 'dart:convert';

import 'package:consultame/device.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:flutter/material.dart';

class Census extends StatelessWidget {
  const Census({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CensusStatefulWidget();
  }
}

class CensusStatefulWidget extends StatefulWidget {
  const CensusStatefulWidget({Key? key}) : super(key: key);

  @override
  State<CensusStatefulWidget> createState() => _CensusStatefulWidgetState();
}

class _CensusStatefulWidgetState extends State<CensusStatefulWidget> {
  String _background =
      "https://storage.googleapis.com/encuesta-tinmarin.appspot.com/FONDO-PRUEBA.jpg";

  Future<Task> getJsonTask() async {
    final taskJson = await getDeviceData();
    final taskMap = taskJson;
    _background = taskJson['bg'].toString();
    return Task.fromJson(taskMap);
  }

  void storeSurvey(SurveyResult result) {
    final results = result.results;
    final surveyResult = <String, String?>{};
    for (StepResult step in results) {
      if (step.id != null &&
          !['instruction', 'completion']
              .contains(step.results[0].valueIdentifier)) {
        surveyResult[step.id!.id] = step.results[0].valueIdentifier;
      }
    }
    registerSurvey(result.id!.id, surveyResult);
  }

  @override
  Widget build(BuildContext context) {
    const baseBlue = Color(0xff2e7cbf);
    const baseBlack = Colors.black87;
    const Map<int, Color> color = {
      50: Color.fromRGBO(46, 124, 191, .1),
      100: Color.fromRGBO(46, 124, 191, .2),
      200: Color.fromRGBO(46, 124, 191, .3),
      300: Color.fromRGBO(46, 124, 191, .4),
      400: Color.fromRGBO(46, 124, 191, .5),
      500: Color.fromRGBO(46, 124, 191, .6),
      600: Color.fromRGBO(46, 124, 191, .7),
      700: Color.fromRGBO(46, 124, 191, .8),
      800: Color.fromRGBO(46, 124, 191, .9),
      900: Color.fromRGBO(46, 124, 191, 1),
    };
    ThemeData myTheme = ThemeData(
      fontFamily: "Montserrat",
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: const MaterialColor(0xff2e7cbf, color)),
      backgroundColor: Colors.white.withOpacity(0.2),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            const Size(150.0, 60.0),
          ),
          side: MaterialStateProperty.resolveWith(
            (Set<MaterialState> state) {
              if (state.contains(MaterialState.disabled)) {
                return const BorderSide(
                  color: Colors.grey,
                );
              }
              return const BorderSide(color: Color.fromRGBO(46, 124, 191, 1));
            },
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          textStyle: MaterialStateProperty.resolveWith(
            (Set<MaterialState> state) {
              if (state.contains(MaterialState.disabled)) {
                return Theme.of(context).textTheme.button?.copyWith(
                      color: Colors.black,
                    );
              }
              return Theme.of(context).textTheme.button?.copyWith(
                    color: const Color.fromRGBO(46, 124, 191, 1),
                  );
            },
          ),
        ),
      ),
      textTheme: const TextTheme(
        headline2: TextStyle(
          fontSize: 30.0,
          color: baseBlack,
          fontWeight: FontWeight.bold,
        ),
        headline5: TextStyle(
          fontSize: 24.0,
          color: baseBlack,
        ),
        bodyText2: TextStyle(
          fontSize: 18.0,
          color: baseBlack,
        ),
        subtitle1: TextStyle(
          fontSize: 18.0,
          color: baseBlack,
        ),
      ),
    );
    return FutureBuilder<Task>(
      future: getJsonTask(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data != null) {
          final task = snapshot.data!;
          return Container(
            //padding: const EdgeInsets.only(left: 80, right: 80, bottom: 150),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(_background), fit: BoxFit.cover),
            ),
            child: SurveyKit(
              onResult: (SurveyResult result) {
                storeSurvey(result);
                Navigator.pop(context);
              },
              task: task,
              showProgress: true,
              localizations: const {
                'cancel': 'Cancelar',
                'next': 'Siguiente',
              },
              themeData: myTheme,
              surveyProgressbarConfiguration: SurveyProgressConfiguration(
                backgroundColor: Colors.white,
              ),
            ),
          );
        }
        return const CircularProgressIndicator.adaptive();
      },
    );
  }
}
