// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

abstract class GoogleMapExampleAppPage extends StatelessWidget {
   const GoogleMapExampleAppPage(this.leading, this.title);

  final Widget leading;
  final String title;
}