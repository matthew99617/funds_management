import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceHelper {
  static String listValueSharedPreferences = 'saveList';
  static String recordValueSharedPreferences = 'saveRecord';
  static String permissionRecordValueSharedPreferences = 'savePermissionRecord';
  static String permissionCalendarValueSharedPreferences = 'savePermissionCalendar';
  static String loginValueSharedPreferences = 'saveLogin';
  static String emailValueSharedPreferences = 'saveEmail';

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
    return sharedPreferences.getString(recordValueSharedPreferences);
  }

  static Future saveRecordPermission(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(permissionRecordValueSharedPreferences, value);
  }

  static Future getRecordPermission() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(permissionRecordValueSharedPreferences);
  }

  static Future saveCalendarPermission(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(permissionCalendarValueSharedPreferences, value);
  }

  static Future getCalendarPermission() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(permissionCalendarValueSharedPreferences);
  }

  static Future saveIsLogin(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(loginValueSharedPreferences, value);
  }

  static Future getIsLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(loginValueSharedPreferences);
  }

  // Write DATA
  static Future saveEmail(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(emailValueSharedPreferences, value);
  }

  // Read Data
  static Future getEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(emailValueSharedPreferences);
  }
}