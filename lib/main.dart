import 'package:consultame/census.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const Map<int, Color> color = {
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TinMarin Survey',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: const MaterialColor(0xff2e7cbf, color),
        bottomAppBarColor: const MaterialColor(0xff2e7cbf, color),
        fontFamily: 'Montserrat',
        backgroundColor: Colors.white70,
      ),
      home: const MyHomePage(title: 'Bienvenido a Tin Marin'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ButtonStyle nextButton = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 50),
  );

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/splash/main.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: 200, height: 70),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Census()));
                  },
                  child: const Text('Continuar'),
                  style: nextButton,
                ),
              ),
              const Text("", style: TextStyle(height: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
