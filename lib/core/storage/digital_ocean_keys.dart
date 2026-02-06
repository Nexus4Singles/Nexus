import 'package:minio_flutter/minio.dart';

class DigitalOceanConfig {
  const DigitalOceanConfig._();
  static const String spacesEndpoint =
      'nexus-userdata.ams3.digitaloceanspaces.com'; 
  static const String spaceName = "nexus-userdata";
  static const String region = "ams3"; 
  static const String accessKey = 'DO8019XHDU4WJFTWXWD2';
  static const String secretKey = 'qQWnU+v80uXReJTPHiZBfJ6sn5yqs0H1kAThApY4gQM';
  static void initDigitalOcean() {
    Minio.init(
      endPoint: spacesEndpoint,
      accessKey: accessKey,
      secretKey: secretKey,
      region: region,
    );
  }
}
