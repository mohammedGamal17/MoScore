import 'package:flutter/material.dart';

import '../../resources/components/live_matches.dart';
import '../../resources/values/values_manager.dart';

class MatchesView extends StatelessWidget {
  const MatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: Column(
          children: const [
            LiveMatches(),
          ],
        ),
      ),
    );
  }
}
