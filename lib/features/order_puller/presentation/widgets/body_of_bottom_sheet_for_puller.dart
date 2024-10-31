import 'package:flutter/material.dart';
import '../../../login/presentation/manager/auth_provider.dart';
import '../manager/map_of_puller_provider.dart';

class BodyOfBottomSheetOfPuller extends StatelessWidget {
  const BodyOfBottomSheetOfPuller({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.6,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Consumer<MapOfPullerProvider>(builder: (context, state, child) {
        return state.currentWidget ?? SizedBox();
      }),
    );
  }
}
