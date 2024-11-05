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
    tabController = TabController(length: 3, vsync: this);

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
                padding: const EdgeInsets.only(bottom: 10),
                controller: tabController,
                tabs: <Tab>[
                  Tab(
                      child: index == 0
                          ? _widgetOfTabSelected(
                              title: "الكل", count: "${state.countOfAll ?? 0}")
                          : _widgetOfTabUnSelected(
                              title: "الكل",
                              count: "${state.countOfAll ?? 0}")),
                  Tab(
                      child: index == 1
                          ? _widgetOfTabSelected(
                              title: "المكتمل",
                              count: "${state.countOfCompleted ?? 0}")
                          : _widgetOfTabUnSelected(
                              title: "المكتمل",
                              count: "${state.countOfCompleted ?? 0}")),
                  Tab(
                      child: index == 2
                          ? _widgetOfTabSelected(
                              title: "الملغية",
                              count: "${state.countOfCancel ?? 0}")
                          : _widgetOfTabUnSelected(
                              title: "الملغية",
                              count: "${state.countOfCancel ?? 0}")),
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

  Widget _widgetOfTabSelected({required String title, required String count}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(60)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: 17.sp, fontWeight: FontWeight.w600),
          ),
          5.pw,
          FittedBox(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColor.yellowColor,
                  borderRadius: BorderRadius.circular(60)),
              child: Text(
                count,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetOfTabUnSelected(
      {required String title, required String count}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          border: Border.all(
            color: Colors.white,
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontSize: 17.sp, fontWeight: FontWeight.w600),
          ),
          5.pw,
          FittedBox(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColor.lightGreyColor2,
                  borderRadius: BorderRadius.circular(60)),
              child: Text(
                count,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
