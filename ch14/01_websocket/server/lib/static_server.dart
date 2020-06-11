library static_server;

import 'dart:io';


final InternetAddress host = InternetAddress.anyIPv4;
const int port = 8080;

bool matchPath(String path) {
  path = path.toLowerCase();
  return path.endsWith('.html') ||
      path.endsWith('.dart') ||
      path.endsWith('.css') ||
      path.endsWith('.js') ||
      path.endsWith('.ico') ||
      path.endsWith('.png') ||
      path.endsWith('.jpg') ||
      path.endsWith('.json');
}

ContentType getConentType(String path) {
  path = path.toLowerCase();
  if (path.endsWith('.html')) {
    return ContentType.html;
  } else if (path.endsWith('.json')) {
    return ContentType.json;
  } else if (path.endsWith('.ico') ||
      path.endsWith('.png') ||
      path.endsWith('.jpg')) {
    return ContentType.binary;
  }
  return ContentType.text;
}
