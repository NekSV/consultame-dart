import 'package:flutter/foundation.dart';

class Question {
  const Question({
    required this.statement,
    required this.id,
    required this.allowedAnswers,
  });

  final String statement;
  final String id;
  final List<String> allowedAnswers;
}

@immutable
class Survey {
  const Survey({
    required this.name,
    required this.questions,
  });

  final String name;
  final List<Question> questions;

  Survey.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          questions: (json['questions']! as List).cast<Question>(),
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
    };
  }
}
