import 'dart:io';

enum PlatformProject { android, ios }

extension PlatformProjectExtension on PlatformProject {
  int get versionNumber {
    return Platform.isIOS
        ? PlatformProject.ios.index
        : PlatformProject.android.index;
  }
}
