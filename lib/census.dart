import 'package:consultame/device.dart';
import 'package:consultame/survey.dart';
import 'package:flutter/material.dart';

class Census extends StatelessWidget {
  const Census({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Encuesta'),
      ),
      body: const Center(
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: const [
          //     Text('First Try to change screen')
          //   ],
          child: MyStatefulWidget()),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _index = 0;
  String? _deviceId;
  Survey? _survey;

  @override
  void initState() {
    super.initState();
    initSurveyState();
  }

  Future<void> initSurveyState() async {
    try {
      String? id = await getUniqueId();
      Survey survey = await getDeviceData();
      if (!mounted) return;
      setState(() {
        _deviceId = id;
        _survey = survey;
      });
    } catch (error) {
      await registerDevice();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.horizontal,
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          title: const Text(''),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 1')),
        ),
        const Step(
          title: Text(''),
          content: Text('Content for Step 2'),
        ),
      ],
    );
  }
}
