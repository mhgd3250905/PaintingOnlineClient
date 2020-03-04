import 'package:shared_preferences/shared_preferences.dart';

/// create on 2019/5/30 by JasonZhang
/// desc：本地储存
class SharedPreferenceUtil {
  //用来保存本地登录的用户id
  static const String KEY_REMOTE_USER_ID = 'key_remote_user_id';

  // 异步保存
  static Future save(String key, String value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  // 异步读取
  static Future<String> get(String key, String defaultValue) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String value = sp.getString(key);
    return value == null ? defaultValue : value;
  }
}
