import 'package:makeitcount/objectbox.g.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as path;

class ObjectBoxDatabase {
  late final Store store;

  ObjectBoxDatabase._create(this.store) {
    // Code to run on setup
  }

  static Future<ObjectBoxDatabase> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store =
        await openStore(directory: path.join(docsDir.path, "makeitcount"));
    return ObjectBoxDatabase._create(store);
  }
}
