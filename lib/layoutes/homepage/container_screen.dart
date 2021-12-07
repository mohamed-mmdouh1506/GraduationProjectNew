import 'package:flutter/material.dart';

import 'drawer_screen.dart';
import 'layout_screen.dart';

class ContainerScreen extends StatelessWidget {
  const ContainerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:   [
          DrawerScreen(),
          const LayoutScreen(),
        ],
      ),
    );
  }
}
