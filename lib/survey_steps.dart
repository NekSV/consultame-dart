import 'package:consultame/survey.dart';
import 'package:flutter/material.dart';

List<Step> buildSteps(List<Question> questions) {
  List<Step> steps = [];
  steps.add(
    Step(
      title: const Text(''),
      content: Container(
        alignment: Alignment.centerLeft,
        child: Text('ninni'),
      )
    )
  );
  for (var q in questions) {
    steps.add(Step(
      title: const Text(''),
      content: Container(
          alignment: Alignment.centerLeft, child: Text(q.statement.toString())),
    ));
  }
  return steps;
}
