import 'package:flutter/material.dart';
import '../../../login/presentation/manager/auth_provider.dart';
import '../manager/map_information.dart';

class BodyOfBottomSheet extends StatelessWidget {
  const BodyOfBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Consumer<MapInformation>(builder: (context, state, child) {
        return state.currentWidget;
      }),
    );
  }
}
