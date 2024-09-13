//
//  adaptive_nav_rail.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 15/11/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

class AdaptiveNavRailModel {
  // Properties
  final Widget label;
  final Widget icon;

  // Class Constructor
  AdaptiveNavRailModel({required this.label, required this.icon});
}

class AdaptiveNavRail extends StatefulWidget {
  // Properties
  final int selectedIndex;
  final ValueChanged<int>? onTap;
  final Color? backgroundColor;
  final double? elevation;
  final bool extended;
  final List<AdaptiveNavRailModel> models;

  // Class Constructor
  const AdaptiveNavRail({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.models,
    this.backgroundColor = ColorPalette.whiteBGColor,
    this.elevation = 3,
    this.extended = true,
  });

  // Widget State
  @override
  State<AdaptiveNavRail> createState() => _AdaptiveNavRailState();
}

class _AdaptiveNavRailState extends State<AdaptiveNavRail> {
  // Properties
  late bool extended;
  IconData iconData = Icons.keyboard_double_arrow_left;

  // Widget Methods
  @override
  void initState() {
    extended = widget.extended;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<NavigationRailDestination> destination = [];
    for (AdaptiveNavRailModel model in widget.models) {
      var item = NavigationRailDestination(
        icon: model.icon,
        label: model.label,
      );
      destination.add(item);
    }

    return Stack(children: [
      NavigationRail(
        extended: extended,
        elevation: widget.elevation,
        backgroundColor: widget.backgroundColor,
        destinations: destination,
        selectedIndex: widget.selectedIndex,
        onDestinationSelected: widget.onTap,
      ),
      Positioned(
        bottom: 16,
        right: 24,
        child: AdaptiveTapGesture(
            onTap: () {
              setState(() {
                extended = !extended;
                iconData = Icons.keyboard_double_arrow_right;
                if (extended) {
                  iconData = Icons.keyboard_double_arrow_left;
                }
              });
            },
            child: Icon(iconData)),
      ),
    ]);
  }
}
