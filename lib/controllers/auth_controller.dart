import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthController {
  final storage = FlutterSecureStorage();

  saveUserIdAndLoginStatus(String userId, String isLoggedFlag) async {
    await storage.write(key: 'UserId', value: userId);
    await storage.write(key: 'IsLoggedFlag', value: isLoggedFlag);
  }

  getUserIdAndLoginStatus() async {
    String userId = await storage.read(key: 'UserId');
    String isLoggedFlag = await storage.read(key: 'IsLoggedFlag');
    return [userId, isLoggedFlag];
  }

  deleteUserIdAndLoginStatus() async {
    await storage.deleteAll();
  }
}
