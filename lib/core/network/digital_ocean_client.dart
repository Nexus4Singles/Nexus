import 'dart:developer';
import 'package:minio_flutter/io.dart';
import 'package:minio_flutter/minio.dart';

import '../storage/digital_ocean_keys.dart';

class DigitalOceanClient {
  late Minio minio;
  DigitalOceanClient() {
    initSpace();
  }

  void initSpace() {
    minio = Minio.init(
      endPoint: DigitalOceanConfig.spacesEndpoint,
      accessKey: DigitalOceanConfig.accessKey,
      secretKey: DigitalOceanConfig.secretKey,
      region: DigitalOceanConfig.region,
      // useSSL: false,
      // enableTrace: true,
    );
  }

//upload file
  Future<String> uploadFileToSpace({
    required String bucket,
    required String objectName,
    required String filePath,
  }) async {
    try {
      var string = await minio.fPutObject(
        bucket,
        objectName,
        filePath,
        {'x-amz-acl': 'public-read'},
      );
      if (string.isNotEmpty) {
        String finalUrl = 'https://${minio.endPoint}/$bucket/$objectName';
        log(finalUrl, name: 'This is the returned URL');
        return finalUrl;
      }
      return '';
    } catch (e) {
      throw 'Something wrong occured: $e';
    }
  }

  //delete file
}
