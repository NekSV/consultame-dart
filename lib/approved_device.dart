import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class ApprovedDevice {
  const ApprovedDevice({
    required this.brand,
    required this.device,
    required this.id,
    required this.model,
    required this.survey,
  });

  final String brand;
  final String device;
  final String id;
  final String model;
  final DocumentReference survey;

  ApprovedDevice.fromJson(Map<String, Object?> json)
      : this(
      brand: json['brand']! as String,
      device: json['device']! as String,
      id: json['id']! as String,
      model: json['model']! as String,
      survey: json['survey']! as DocumentReference);

  Map<String, Object?> toJson() {
    return {
      'brand': brand,
      'device': device,
      'id': id,
      'model': model,
      'survey': survey,
    };
  }
}