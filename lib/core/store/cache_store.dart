import 'dart:io';

import 'package:dappstore/core/store/i_cache_store.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@LazySingleton(as: ICacheStore)
class CacheStore implements ICacheStore {
  late HiveCacheStore hiveCacheStore;
  CacheStore();
  @override
  initialise() async {
    Directory appDocDirectory = await getApplicationSupportDirectory();
    if (await appDocDirectory.exists()) {
    } else {
      await Directory(appDocDirectory.absolute.toString())
          .create(recursive: true);
    }
    final path = "${appDocDirectory.path}/cacheStore";
    hiveCacheStore = HiveCacheStore(path);
  }

  @override
  HiveCacheStore get cacheStore => hiveCacheStore;

  @override
  Iterable<DioCacheInterceptor> get dioCacheInterceptor => [
        DioCacheInterceptor(
          options:
              CacheOptions(store: cacheStore, policy: CachePolicy.forceCache),
        )
      ];
}
