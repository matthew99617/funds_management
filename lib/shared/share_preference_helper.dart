import 'package:shared_preferences/shared_preferences.dart';

import '../model/notes.dart';

class SharePreferenceHelper {
  static String listValueSharedPreferences = 'saveList';
  static String recordValueSharedPreferences = 'saveRecord';

  // Write List DATA
  static Future<bool> saveListData(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(listValueSharedPreferences, value);
  }

  // Read List Data
  static Future<String> getListData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(listValueSharedPreferences)!;
  }

  // Write DATA
  static Future saveRecordData(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(recordValueSharedPreferences, value);
  }

  // Read Data
  static Future getRecordData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(recordValueSharedPreferences);
  }
}