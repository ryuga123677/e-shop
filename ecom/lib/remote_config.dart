import 'package:firebase_remote_config/firebase_remote_config.dart';
class firebaseremote{
  final remoteconfig=FirebaseRemoteConfig.instance;
  Future initializeconfig()async {
    remoteconfig.setConfigSettings(RemoteConfigSettings(fetchTimeout: Duration(seconds: 2), minimumFetchInterval: Duration(seconds: 2)));
  await remoteconfig.fetchAndActivate();
  var temp=remoteconfig.getBool('checking');
  return temp;
  }
}