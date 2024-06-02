import 'package:flutter/material.dart';

import 'models/scope_enum.dart';

Color colorByLocale(Scope scope) {
  switch (scope) {
    case Scope.local:
      return Colors.green;
    case Scope.state:
      return Colors.yellow;
    case Scope.national:
      return Colors.red;
    case Scope.global:
      return Colors.blue; 
  }
}
