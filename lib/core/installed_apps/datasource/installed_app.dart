import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class InstalledAppsUtils {
  static Future<List<AppInfo>?> getInstalledApps(
      {required bool excludeSystemApps,
      required bool withIcon,
      required String packageNamePrefix}) async {
    try {
      List<AppInfo>? apps = await InstalledApps.getInstalledApps(
        excludeSystemApps,
        withIcon,
        packageNamePrefix,
      );
      return apps;
    } catch (e) {
      //todo: error logger here
      return null;
    }
  }

  static Future<AppInfo?> getAppInfo({required String packageName}) async {
    try {
      AppInfo? appInfo = await InstalledApps.getAppInfo(packageName);
      return appInfo;
    } catch (e) {
      //todo: error logger here
      return null;
    }
  }

  static Future<bool?> startApp({required String packageName}) async {
    try {
      bool? status = await InstalledApps.startApp(packageName);
      return status;
    } catch (e) {
      //todo: error logger here
      return null;
    }
  }

  static Future<bool?> openSettings({required String packageName}) async {
    try {
      bool? status = await InstalledApps.openSettings(packageName);
      return status;
    } catch (e) {
      //todo: error logger here
      return null;
    }
  }

  static Future<bool?> isSystemApp({required String packageName}) async {
    try {
      bool? isSystemApp = await InstalledApps.isSystemApp(packageName);
      return isSystemApp;
    } catch (e) {
      //todo: error logger here
      return null;
    }
  }
}
