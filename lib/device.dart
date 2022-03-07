import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
final CollectionReference devices =
FirebaseFirestore.instance.collection('devices');

Future<AndroidDeviceInfo> getDeviceInfo() async {
  return DeviceInfoPlugin().androidInfo;
}

Future<String?> getUniqueId() async {
  AndroidDeviceInfo info = await getDeviceInfo();
  return info.androidId;
}

Future<void> getDeviceData() async {

  String? id = await getUniqueId();
  DocumentSnapshot<Object?> data = await devices.doc(id).get();
  if (data.exists == false) {
    registerDevice();
  }else{
    print('buscando datos');
  }
}

Future<void> registerDevice() async {
  AndroidDeviceInfo info = await getDeviceInfo();
  return devices.doc(info.androidId)
      .set({
        'id': info.androidId,
        'brand': info.brand,
        'device': info.device,
        'model': info.model,
      })
      .then((value) => getDeviceData())
      .catchError((error) => print('something went wrong!'));
}
