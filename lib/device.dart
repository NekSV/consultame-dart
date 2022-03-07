import 'package:device_info_plus/device_info_plus.dart';

Future<String?> getUniqueId() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
  return info.androidId;
}
