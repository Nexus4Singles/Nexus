import 'package:minio_flutter/minio.dart';

class DigitalOceanConfig {
  const DigitalOceanConfig._();
  static const String spacesEndpoint =
      'nexus-userdata.ams3.digitaloceanspaces.com'; 
  static const String spaceName = "nexus-userdata";
  static const String region = "ams3"; 
  static const String accessKey = 'DO00LCBE9MG72AWRXBJ9';
  static const String secretKey = 'ldMxMFgJ3kJ+HsphZxVF8S8LgAjiBzGVk8xk5hU/icw';
  static void initDigitalOcean() {
    Minio.init(
      endPoint: spacesEndpoint,
      accessKey: accessKey,
      secretKey: secretKey,
      region: region,
    );
  }
}
