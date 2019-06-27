import './local_storage_utils.dart';
import '../model/user_info.dart';

class UserUtils {
  static const USER_INFO_KEY = "USER_INFO_KEY";

  static saveUserInfo(UserInfo userInfo) {
    if (userInfo != null) {
      LocalStorage.putObject(USER_INFO_KEY, userInfo.toJson());
    }
  }

  static removeUserInfo() {
    LocalStorage.remove(USER_INFO_KEY);
  }

  static getUserInfo() {
    Map userJson = LocalStorage.getObject(USER_INFO_KEY);
    return userJson == null ? null : UserInfo.fromJson(userJson);
  }

  static bool isLogin() {
    var res = getUserInfo() == null ? false : true;
    return res;
  }
}
