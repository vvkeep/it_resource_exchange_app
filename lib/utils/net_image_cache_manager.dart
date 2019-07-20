import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class NetImageCacheManager extends BaseCacheManager {

  static String key = "libCachedImageData";

  static NetImageCacheManager _instance;

  /// The DefaultCacheManager that can be easily used directly. The code of
  /// this implementation can be used as inspiration for more complex cache
  /// managers.
  factory NetImageCacheManager(String cacheKey) {
    if (_instance == null) {
      NetImageCacheManager.key = cacheKey;
      _instance = new NetImageCacheManager._();
    }
    return _instance;
  }

  NetImageCacheManager._() : super(key);

  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return p.join(directory.path, key);
  }
  
}