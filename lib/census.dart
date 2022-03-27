import 'package:consultame/device.dart';
import 'package:flutter/cupertino.dart';
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
  final String _background =
      "https://storage.googleapis.com/encuesta-tinmarin.appspot.com/FONDO-PRUEBA.jpg";
  MaterialColor primaryMaterialColor = const MaterialColor(
    4279074754,
    <int, Color>{
      50: Color.fromRGBO(
        13,
        127,
        194,
        .1,
      ),
      100: Color.fromRGBO(
        13,
        127,
        194,
        .2,
      ),
      200: Color.fromRGBO(
        13,
        127,
        194,
        .3,
      ),
      300: Color.fromRGBO(
        13,
        127,
        194,
        .4,
      ),
      400: Color.fromRGBO(
        13,
        127,
        194,
        .5,
      ),
      500: Color.fromRGBO(
        13,
        127,
        194,
        .6,
      ),
      600: Color.fromRGBO(
        13,
        127,
        194,
        .7,
      ),
      700: Color.fromRGBO(
        13,
        127,
        194,
        .8,
      ),
      800: Color.fromRGBO(
        13,
        127,
        194,
        .9,
      ),
      900: Color.fromRGBO(
        13,
        127,
        194,
        1,
      ),
    },
  );

  @override
  Widget build(BuildContext context) {
    ThemeData myTheme = ThemeData(
      fontFamily: "Montserrat",
      primaryColor: const Color(0xff0d7fc2),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color(0xff0d7fc2),
          ),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryMaterialColor)
          .copyWith(secondary: const Color(0xff0d7fc4)),
      backgroundColor: Colors.white.withOpacity(0.5),
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: Color(0xff0d7fc4),
      ),
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
              return const BorderSide(
                color: Color(0xff0d7fc8),
              );
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
                      color: Colors.grey,
                    );
              }
              return Theme.of(context).textTheme.button?.copyWith(
                    color: Colors.cyan,
                  );
            },
          ),
        ),
      ),
      textTheme: const TextTheme(
        headline2: TextStyle(
          fontSize: 30.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        headline5: TextStyle(
          fontSize: 24.0,
          color: Colors.black,
        ),
        bodyText2: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
        ),
        subtitle1: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
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
            padding: const EdgeInsets.only(left: 80, right: 80, bottom: 150),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(_background), fit: BoxFit.cover)),
            child: SurveyKit(
              onResult: (SurveyResult result) {
                print(result.results);
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

  Future<Task> getJsonTask() async {
    final taskJson = await getDeviceData();
    final taskMap = taskJson;
    return Task.fromJson(taskMap);
  }
}
