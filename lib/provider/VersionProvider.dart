


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/model/version.dart';
import 'package:package_info_plus/package_info_plus.dart';

final versionProvider = StateProvider<Version?>((ref) => null);

final currentVersionProvider = FutureProvider<Version>((ref) async{

  final packageInFo=await PackageInfo.fromPlatform();

  return Version(version: packageInFo.version, status: 1);
});