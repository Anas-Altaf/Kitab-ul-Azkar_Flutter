import 'package:url_launcher/url_launcher.dart';

launchURL({required String urlString}) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
