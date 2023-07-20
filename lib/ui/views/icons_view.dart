import 'package:flutter/material.dart';

import '../cards/white_card.dart';
import '../labels/custom_labels.dart';

class IconsView extends StatelessWidget {
  const IconsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: <Widget>[
        Text('Icons', style: CustomLabels.h1),
        const SizedBox(height: 10),
        const Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          direction: Axis.horizontal,
          children: <Widget>[
            WhiteCard(
              width: 170,
              title: 'ac_outlined',
              child: Center(
                child: Icon(Icons.ac_unit_outlined),
              ),
            ),
            WhiteCard(
              width: 170,
              title: 'access_alarm_sharp',
              child: Center(
                child: Icon(Icons.access_alarm_sharp),
              ),
            ),
            WhiteCard(
              width: 170,
              title: 'cabin_outlined',
              child: Center(
                child: Icon(Icons.cabin_outlined),
              ),
            ),
            WhiteCard(
              width: 170,
              title: 'kayaking_outlined',
              child: Center(
                child: Icon(Icons.kayaking_outlined),
              ),
            ),
            WhiteCard(
              width: 170,
              title: 'arrow_upward_outlined',
              child: Center(
                child: Icon(Icons.arrow_upward_outlined),
              ),
            ),
            WhiteCard(
              width: 170,
              title: 'ice_skating_outlined',
              child: Center(
                child: Icon(Icons.ice_skating_outlined),
              ),
            ),
            WhiteCard(
              width: 170,
              title: 'nat_outlined',
              child: Center(
                child: Icon(Icons.nat_outlined),
              ),
            ),
            WhiteCard(
              width: 170,
              title: 'macro_off_outlined',
              child: Center(
                child: Icon(Icons.macro_off_outlined),
              ),
            ),
            WhiteCard(
              width: 170,
              title: 'u_turn_left_outlined',
              child: Center(
                child: Icon(Icons.u_turn_left_outlined),
              ),
            ),
          ],
        )
      ],
    );
  }
}
