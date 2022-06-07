import 'package:get_it/get_it.dart';
import 'package:sats/api/interface/libbitcoin.dart';
import 'package:sats/api/interface/logger.dart';
import 'package:sats/api/libbitcoin.dart';
import 'package:sats/api/logger.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/pkg/clipboard.dart';
import 'package:sats/pkg/interface/clipboard.dart';
import 'package:sats/pkg/interface/launcher.dart';
import 'package:sats/pkg/interface/share.dart';
import 'package:sats/pkg/interface/storage.dart';
import 'package:sats/pkg/interface/vibrate.dart';
import 'package:sats/pkg/launcher.dart';
import 'package:sats/pkg/share.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/pkg/vibrate.dart';

GetIt locator = GetIt.instance;

void setupDependencies({required bool useDummies}) {
  if (useDummies) {
    locator.registerLazySingleton<IStorage>(() => HiveStore());
    locator.registerLazySingleton<IClipBoard>(() => ClipBoard());
    locator.registerLazySingleton<IShare>(() => Sharer());
    locator.registerSingleton<ILauncher>(Launcher());
    locator.registerLazySingleton<IVibrate>(() => Vibrate());
    locator.registerLazySingleton<IStackMateBitcoin>(() => LibBitcoin());
    locator.registerLazySingleton<ILogAPI>(() => DummyLogAPI());
  } else {
    locator.registerLazySingleton<IShare>(() => Sharer());
    locator.registerLazySingleton<ILauncher>(() => Launcher());
    locator.registerLazySingleton<IClipBoard>(() => ClipBoard());
    locator.registerLazySingleton<IStorage>(() => HiveStore());
    locator.registerLazySingleton<IStackMateBitcoin>(() => LibBitcoin());
    locator.registerLazySingleton<IVibrate>(() => Vibrate());
    locator.registerLazySingleton<ILogAPI>(() => SentryLogger());
  }

  final loggerCubit = Logger(
    locator<IClipBoard>(),
    locator<ILogAPI>(),
  );

  locator.registerLazySingleton<Logger>(() => loggerCubit);
}
