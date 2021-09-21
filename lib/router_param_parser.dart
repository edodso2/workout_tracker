import 'package:flutter/material.dart';

class ParsedRoute {
  String name;
  List<dynamic> params;

  ParsedRoute(this.name, this.params);
}

class RouterParamParser {
  List<String> routeNames;

  RouterParamParser(this.routeNames);

  ParsedRoute parse(RouteSettings settings) {
    final List<String> pathElements = settings.name.split('/');

    if (pathElements[0] != '') {
      return null;
    }
    if (routeNames.contains(pathElements[1])) {
      return ParsedRoute(pathElements[1], pathElements.sublist(2));
    }
    return null;
  }
}
