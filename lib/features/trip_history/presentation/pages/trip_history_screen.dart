import 'package:fisaa/core/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_color.dart';
import '../../../../core/enums/request_state.dart';
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import '../../../login/presentation/manager/auth_provider.dart';
import '../manager/trip_history_provider.dart';
import '../widgets/item_of_trip.dart';

class TripHistoryScreen extends StatefulWidget {
  @override
  State<TripHistoryScreen> createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int index = 0;
  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);

    super.initState();
  }

  _updateTheIndex(int tempIndex) {
    setState(() {
      index = tempIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor.mainColor,
          centerTitle: true,
          title: Text(
            'رحلاتي',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(55.h), // Adjust height here

            child:
                Consumer<TripHistoryProvider>(builder: (context, state, child) {
              return TabBar(
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                padding: EdgeInsets.only(bottom: 10),
                labelPadding: EdgeInsets.symmetric(horizontal: 5),
                // labelPadding: EdgeInsets.symmetric(horizontal: 5),
                controller: tabController,
                tabs: <Tab>[
                  Tab(
                      child: index == 0
                          ? _widgetOfTabSelected(title: "الكل")
                          : _widgetOfTabUnSelected(title: "الكل")),
                  Tab(
                      child: index == 1
                          ? _widgetOfTabSelected(title: "في الطريق")
                          : _widgetOfTabUnSelected(title: "في الطريق")),
                  Tab(
                      child: index == 2
                          ? _widgetOfTabSelected(title: "تم الوصول")
                          : _widgetOfTabUnSelected(title: "تم الوصول")),
                  Tab(
                      child: index == 3
                          ? _widgetOfTabSelected(title: "المكتمل")
                          : _widgetOfTabUnSelected(title: "المكتمل")),
                  Tab(
                      child: index == 4
                          ? _widgetOfTabSelected(title: "الملغية")
                          : _widgetOfTabUnSelected(title: "الملغية")),
                ],
                onTap: (x) => _updateTheIndex(x),
              );
            }),
          )),
      body: Container(
        color: Colors.grey.shade200,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Consumer<TripHistoryProvider>(builder: (context, state, child) {
          return TabBarView(controller: tabController, children: <Widget>[
            state.stateOfHistory == RequestState.loading
                ? const CupertinoActivityIndicator()
                : _listOfAllTrips(
                    data: state.allHistoryTrips, context: context),
            state.stateOfHistory == RequestState.loading
                ? const CupertinoActivityIndicator()
                : _listOfAllTrips(
                    data: state.onWayHistoryTrips, context: context),
            state.stateOfHistory == RequestState.loading
                ? const CupertinoActivityIndicator()
                : _listOfAllTrips(
                    data: state.arrivedHistoryTrips, context: context),
            state.stateOfHistory == RequestState.loading
                ? const CupertinoActivityIndicator()
                : _listOfAllTrips(
                    data: state.completedHistoryTrips, context: context),
            state.stateOfHistory == RequestState.loading
                ? const CupertinoActivityIndicator()
                : _listOfAllTrips(
                    data: state.cancelHistoryTrips, context: context),
          ]);
        }),
      ),
    );
  }

  _listOfAllTrips(
      {required List<TripDetailsModel> data, required BuildContext context}) {
    return ListView.separated(
      itemCount: data.length,
      itemBuilder: (_, int index) => ItemOfTrip(
        item: data[index],
      ),
      separatorBuilder: (x, y) => 15.ph,
    );
  }

  Widget _widgetOfTabSelected({required String title}) {
    return FittedBox(
        child: Container(
      padding: EdgeInsets.all(5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(60)),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(fontSize: 17.sp, fontWeight: FontWeight.w600),
      ),
    ));
  }

  Widget _widgetOfTabUnSelected({required String title}) {
    return FittedBox(
      child: Container(
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            border: Border.all(
              color: Colors.white,
            )),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(fontSize: 17.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
