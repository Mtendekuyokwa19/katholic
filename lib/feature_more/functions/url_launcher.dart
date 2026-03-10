import 'package:katholic/constants/endpoints.dart';
import 'package:katholic/constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class URLlaunchers {
  static Future<void> launchURL() async {
    final Uri url = Uri.parse(Endpoints.repo);
    if (!await launchUrl(url)) {
      throw Exception('${Strings.couldNotLaunch}   $url');
    }
  }
}
