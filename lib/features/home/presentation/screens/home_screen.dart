import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/home/presentation/manager/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/enums/request_state.dart';
import '../../../../core/injection/injection_container.dart' as di;
import '../../../../core/app_color.dart';
import '../../../../core/enums/selected_help.dart';
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import '../../../login/presentation/manager/auth_provider.dart';
import '../../../profile/presentation/pages/profile_user_screen.dart';
import '../../../trip_history/presentation/manager/trip_history_provider.dart';
import '../../../trip_history/presentation/pages/trip_history_screen.dart';
import '../widgets/current_trip.dart';
import '../widgets/items_widget.dart';
import 'screen1_home.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> listOfWidgets = [
    Screen1Home(),
    ChangeNotifierProvider<TripHistoryProvider>(
        create: (_) => di.sl<TripHistoryProvider>()..getHistoryTrips(),
        child: TripHistoryScreen()),
    ProfileUserScreen(),
  ];
  _updateIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightGreyColor,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          _buildNavItem(AppImages.home, 'الرئيسية', 0),
          _buildNavItem(AppImages.calendar, 'رحلاتي', 1),
          _buildNavItem(AppImages.personIcon, 'حسابي', 2),
        ],
        currentIndex: selectedIndex,
        onTap: (x) => _updateIndex(x),
        selectedLabelStyle: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
        unselectedLabelStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
      ),
      body: listOfWidgets[selectedIndex],
    );
  }

  BottomNavigationBarItem _buildNavItem(String icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          Image.asset(
            icon,
            height: 20.h,
          ),
        ],
      ),
      activeIcon: Column(
        children: [
          Container(
            width: 50.w,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColor.mainColor,
            ),
          ),
          4.ph,
          Image.asset(
            icon,
            height: 20.h,
          ),
        ],
      ),
      label: label,
    );
  }
}
