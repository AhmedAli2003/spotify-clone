import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/core/constants/app_constants.dart';

part 'device_info.g.dart';

@riverpod
DeviceInfoPlugin deviceInfoPlugin(Ref _) => DeviceInfoPlugin();

@riverpod
DeviceInfo deviceInfo(Ref ref) {
  final deviceInfoPlugin = ref.watch(deviceInfoPluginProvider);
  return DeviceInfo(deviceInfoPlugin);
}

class DeviceInfo {
  final DeviceInfoPlugin deviceInfoPlugin;

  DeviceInfo(this.deviceInfoPlugin);

  /// Returns a unique device ID (best effort; not guaranteed to be permanent)
  Future<String> getDeviceId() async {
    if (kIsWeb) {
      final webInfo = await deviceInfoPlugin.webBrowserInfo;
      return webInfo.userAgent ?? AppConstants.unknown;
    }

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      return androidInfo.id;
    }

    if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      return iosInfo.identifierForVendor ?? AppConstants.unknown;
    }

    if (Platform.isWindows) {
      final windowsInfo = await deviceInfoPlugin.windowsInfo;
      return windowsInfo.deviceId;
    }

    if (Platform.isMacOS) {
      final macInfo = await deviceInfoPlugin.macOsInfo;
      return macInfo.systemGUID ?? AppConstants.unknown;
    }

    if (Platform.isLinux) {
      final linuxInfo = await deviceInfoPlugin.linuxInfo;
      return linuxInfo.machineId ?? AppConstants.unknown;
    }

    return AppConstants.unknown;
  }

  /// Returns a readable string like 'iPhone 14 (iOS 17)' or 'Pixel 6 (Android 13)'
  Future<String> getDeviceInfo() async {
    if (kIsWeb) {
      final webInfo = await deviceInfoPlugin.webBrowserInfo;
      return '${webInfo.browserName} (Web)';
    }

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      return '${androidInfo.model} (${androidInfo.version.release})';
    }

    if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      return '${iosInfo.name} (${iosInfo.systemVersion})';
    }

    if (Platform.isWindows) {
      final winInfo = await deviceInfoPlugin.windowsInfo;
      return 'Windows (${winInfo.displayVersion})';
    }

    if (Platform.isMacOS) {
      final macInfo = await deviceInfoPlugin.macOsInfo;
      return 'macOS (${macInfo.osRelease})';
    }

    if (Platform.isLinux) {
      final linuxInfo = await deviceInfoPlugin.linuxInfo;
      return 'Linux (${linuxInfo.version})';
    }

    return AppConstants.unknown;
  }
}
