import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:hive/hive.dart' show Hive;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:path/path.dart' show join;

import 'package:graphql/client.dart' show HiveStore;

Future<void> initHiveForFlutter({
  String subDir,
  Iterable<String> boxes = const [HiveStore.defaultBoxName],
}) async {
  if (!kIsWeb) {
    var appDir = await getApplicationDocumentsDirectory();
    var path = appDir.path;
    if (subDir != null) {
      path = join(path, subDir);
    }
    Hive.init(path);
  }

  for (var box in boxes) {
    await Hive.openBox(box);
  }
}
