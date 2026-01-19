import 'package:baby_look/main.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> lauch_to_url({required String url}) async {
  try {
    await launchUrl(Uri.parse(url));
  } catch (e) {
    logger.e(e);
  }
}
