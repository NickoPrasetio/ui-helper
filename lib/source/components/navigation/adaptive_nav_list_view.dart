//
//  adaptive_nav_list_view.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 15/11/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

class AdaptiveNavListViewModel {
  // Properties
  final Widget? leading;
  final Widget? title;
  final VoidCallback onTap;

  // Class Constructor
  AdaptiveNavListViewModel({
    required this.leading,
    required this.title,
    required this.onTap,
  });
}

class AdaptiveNavListView extends StatelessWidget {
  // Properties
  final List<AdaptiveNavListViewModel> models;
  final DrawerHeader header;

  // Class Constructor
  const AdaptiveNavListView({
    super.key,
    required this.models,
    this.header = const DrawerHeader(
      decoration: BoxDecoration(color: ColorPalette.blue),
      child: Text(''),
    ),
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [header];

    for (AdaptiveNavListViewModel model in models) {
      var item = ListTile(leading: model.leading, title: model.title, onTap: model.onTap);
      children.add(item);
    }

    return ListView(padding: EdgeInsets.zero, children: children);
  }
}
