import 'dart:convert';
import './utils.dart';
import 'package:get_storage/get_storage.dart';
import './RequestBody.dart';

storeRestoreData(RequestBody payload, dynamic jsonData,
    {Duration duration = const Duration(hours: 4)}) {
  final _localStorage = GetStorage();
  final now = DateTime.now();
  final String key = payload.collectionName + payload.amendType;

  try {
    if (jsonData == null) {
      print("Reading cached api data");
      final rawMapData = _localStorage.read(key);
      if (rawMapData == null) return rawMapData;
      dynamic jsonData = Map<String, dynamic>.from(jsonDecode(rawMapData));
      final expiryDate = DateTime.parse(jsonData['expiryTime']);
      if (expiryDate.isBefore(now)) {
        print("api expired skipped reading....");
        return null;
      } else {
        multiPrint([
          "this will expire on",
          expiryDate.toString(),
        ]);
      }
      print(jsonData['data'].runtimeType);
      return jsonData['data'];
    } else {
      print("Writing cached api");
      final jsonEncoder = JsonEncoder();
      _localStorage.write(
          key,
          jsonEncoder.convert({
            "data": jsonData,
            "expiryTime": now.add(duration).toString(),
          }));
      return jsonData;
    }
  } catch (e, s) {
    multiPrint([e, s]);
  }
}
