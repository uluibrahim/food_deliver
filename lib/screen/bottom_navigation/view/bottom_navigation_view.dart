import 'package:flutter/material.dart';
import 'package:food_deliver/screen/bottom_navigation/tab_items_data.dart';
import 'package:food_deliver/screen/bottom_navigation/viewmodel/bottom_navigation_viewmodel.dart';
import 'package:food_deliver/screen/home/home_viewmodel/home_viewmodel.dart';
import 'package:food_deliver/screen/home/view/home_view.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/enums/tab_item_enum.dart';
import '../../basket/view/basket_view.dart';
import '../../profile/view/profile_view.dart';
import '../../search/view/search_view.dart';

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({Key? key}) : super(key: key);

  @override
  State<BottomNavigationView> createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView>
    with TabItemsData, AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: TabItems.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewmodel = Provider.of<BottomNavigationViewmodel>(context);
    return DefaultTabController(
      length: TabItems.values.length,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          controller: _tabController,
          onTap: (index) {
            viewmodel.currentIndex = index;
          },
          tabs: TabItems.values
              .map((e) => getTab(e, viewmodel.currentIndex, context))
              .toList(),
        ),
        body: TabBarView(controller: _tabController, children: [
          ChangeNotifierProvider(
            create: (_) => HomeViewmodel(),
            child: HomeView(navigationViewmodel: viewmodel),
          ),
          const SearchView(),
          BasketView(
              navigationViewmodel: viewmodel, tabController: _tabController),
          const ProfileView(),
        ]),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
