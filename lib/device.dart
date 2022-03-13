import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:consultame/approved_device.dart';

final CollectionReference devices =
    FirebaseFirestore.instance.collection('devices');

/// Get All Device Info
Future<AndroidDeviceInfo> getDeviceInfo() async {
  return DeviceInfoPlugin().androidInfo;
}

/// Get Device Unique ID only
Future<String?> getUniqueId() async {
  AndroidDeviceInfo info = await getDeviceInfo();
  return info.androidId;
}

/// Get Associated data to device on Firestore
Future getDeviceData() async {
  String? id = await getUniqueId();
  DocumentSnapshot<ApprovedDevice> device = await devices
      .doc(id)
      .withConverter<ApprovedDevice>(
          fromFirestore: (snapshots, _) =>
              ApprovedDevice.fromJson(snapshots.data()!),
          toFirestore: (device, _) => device.toJson())
      .get();
  if (device.exists) {
    DocumentSnapshot<Object?> survey = await device
        .data()!
        .survey
        .get();
    return survey.data()!;
  }else{
    registerDevice();
  }

  return null;
}

/// Onboard new device on Firestore
Future<void> registerDevice() async {
  AndroidDeviceInfo info = await getDeviceInfo();
  return devices.doc(info.androidId).set({
    'id': info.androidId,
    'brand': info.brand,
    'device': info.device,
    'model': info.model,
    'survey': null,
  });
}
