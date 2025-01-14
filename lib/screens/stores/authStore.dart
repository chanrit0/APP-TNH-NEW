import 'package:app_tnh2/helper/serviceStore.dart';

Future<dynamic> accessTokenStore({
  required String key,
  String? action,
  String? value,
}) async {
  try {
    switch (action) {
      case "set":
        await setStoreService(key, value!);
        return true;
      case "remove":
        await removeStoreService(key);
        return true;
      default:
        final result = await getStoreService(key);
        return result;
    }
  } catch (err) {
    print("accessTokenStore error ${err.toString()}");
  }
}
