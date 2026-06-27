import 'dart:io';

import 'package:finbrain/data/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class UrlRepository {
  Future<String> fetchAndOpenProductUrl(
    String companyName,
    String productName,
  ) async {
    final client = http.Client();
    final cleanCmpy = companyName.trim();
    final cleanPrdt = productName.trim();
    final String searchQuery = "${cleanCmpy} ${cleanPrdt} 공식 사이트";
    final String encodedQuery = Uri.encodeComponent(searchQuery);
    final String url = "https://html.duckduckgo.com/html/?q=${encodedQuery}";
    
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          "User-Agent":
              "Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1",
        },
      );
      if (response.statusCode == 200) {
        final html = response.body;
        final String searchResultSection = "class=\"links_main";

        final cleanHtml = (html.contains(searchResultSection))
            ? html.split(searchResultSection)[1]
            : html;
        final RegExp urlRegex = RegExp(
          "class=\"result__url\"[^>]*href=\"([^\"]+)\"",
        );
        final Match? match = urlRegex.firstMatch(cleanHtml);

        if (match != null && match.groupCount >= 1) {
          String extracted = match.group(1)!;

          if (extracted.contains("uddg=")) {
            final List<String> parts = extracted.split("uddg=");
            if (parts.length > 1) {
              final String rawUrl = parts[1].split("&")[0];
              extracted = Uri.decodeComponent(rawUrl);
            }
          } else {
            extracted = Uri.decodeComponent(extracted);
          }
          print("success: Found URL: $extracted");
          return extracted;
        } else {
          print("error: No result found");
          return "No result found";
        }
      } else {
        print("error: ${response.statusCode}, ${response.body}");
        return "No result found";
      }
    } catch (error) {
      print("error: Crawling failed: $error");
      return "No result found";
    } finally {
      client.close();
    }
  }

  Future<bool> launchInBrowser(String urlString) async {
    if (urlString.isEmpty || urlString == "No result found") {
      print("error: URL string is invalid or empty");
      return false;
    }

    final Uri? url = Uri.tryParse(urlString);
    if (url == null) {
      print("error: Cannot parse the url string");
      return false;
    }

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
        return true;
      } else {
        print("error: Cannot open the url link via OS");
        return false;
      }
    } catch (error) {
      print("error: launchUrl crashed with exception, $error");
      return false;
    }
  }
}
