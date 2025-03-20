import 'package:flutter/material.dart';

class ParsedRoute {
  final String name;
  final List<String> params;
  
  const ParsedRoute({required this.name, required this.params});
}

class RouterParamParser {
  List<String> routeNames;

  RouterParamParser(this.routeNames);

  ParsedRoute? parse(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '');
    final pathSegments = uri.pathSegments;

    if (pathSegments.isEmpty) {
      return null;
    }
   if (routeNames.contains(pathSegments[0])) {
      return ParsedRoute(
        name: pathSegments[0], 
        params: pathSegments.sublist(1).toList()
      );
    }
    return null;
  }
}
