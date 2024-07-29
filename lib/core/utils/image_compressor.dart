import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageCompressorNexus {
  Future<XFile?> compressAndGetFile(XFile file) async {
    final directory = await getTemporaryDirectory();
    final targetPath =
        path.join(directory.path, 'compressed_${path.basename(file.path)}');

    var result = await FlutterImageCompress.compressAndGetFile(
        file.path, targetPath,
        quality: 88);
    debugPrint(file.length().toString());
    return result;
  }
}
