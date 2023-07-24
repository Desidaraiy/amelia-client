import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/pages/cart.dart';
import 'package:markets/src/pages/category.dart';
import 'package:markets/src/pages/login.dart';
import 'package:markets/src/pages/settings.dart';

import '../elements/DrawerWidget.dart';
import '../elements/FilterWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../pages/home.dart';
import '../pages/search.dart';
import '../pages/map.dart';
import '../pages/notifications.dart';
import '../pages/orders.dart';
import 'favorites.dart';
import 'messages.dart';

// ignore: must_be_immutable
class PagesWidget extends StatefulWidget {
  dynamic currentTab;
  RouteArgument routeArgument;
  // final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKey;
  Widget currentPage;

  PagesWidget({Key key, this.currentTab, this.scaffoldKey}) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 0;
    }
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> {
  List<Widget> _pagesList;
  @override
  void initState() {
    super.initState();
    // _selectTab(widget.currentTab);
    _pagesList = [
      HomeWidget(
          parentScaffoldKey: widget.scaffoldKey,
          routeArgument: widget.routeArgument),
      Search(routeArgument: widget.routeArgument),
      CartWidget(
        routeArgument: widget.routeArgument,
      ),
      OrdersWidget(
        parentScaffoldKey: widget.scaffoldKey,
      ),
      SettingsWidget()
    ];
  }
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _selectTab(widget.currentTab);
  // }

  // @override
  // void didUpdateWidget(PagesWidget oldWidget) {
  //   _selectTab(oldWidget.currentTab);
  //   super.didUpdateWidget(oldWidget);
  // }

  void _selectTab(int tabItem) {
    print('selecting ${tabItem}');
    setState(() {
      widget.currentTab = tabItem;
      // switch (tabItem) {
      //   case 0:
      //     widget.currentPage = HomeWidget(
      //         parentScaffoldKey: widget.scaffoldKey,
      //         routeArgument: widget.routeArgument);
      // widget.currentPage = NotificationsWidget(parentScaffoldKey: widget.scaffoldKey);
      //     break;
      //   case 1:
      //     widget.currentPage = Search(routeArgument: widget.routeArgument);
      //     break;
      //   case 2:
      //     widget.currentPage = CartWidget(
      //       routeArgument: widget.routeArgument,
      //     );
      //     break;
      //   case 3:
      //     widget.currentPage = OrdersWidget(
      //       parentScaffoldKey: widget.scaffoldKey,
      //     );
      //     break;
      //   case 4:
      //     widget.currentPage = SettingsWidget();
      //     break;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: widget.scaffoldKey,
        // endDrawer: FilterWidget(onFilter: (filter) {
        //   Navigator.of(context).pushReplacementNamed('/Pages', arguments: widget.currentTab);
        // }),
        // body: widget.currentPage,
        body: _pagesList[widget.currentTab],
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primary_50,
          selectedFontSize: 12.34,
          unselectedFontSize: 0,
          iconSize: 24,
          elevation: 0,
          selectedLabelStyle: TextStyle(
            fontFamily: 'Jost',
            fontSize: 12.34,
            fontWeight: FontWeight.w400,
          ),
          backgroundColor: primary_700,
          selectedIconTheme: IconThemeData(size: 24),
          // selectedLabelStyle: Theme.of(context).textTheme.overline,
          // unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          currentIndex: widget.currentTab,
          onTap: (int i) {
            this._selectTab(i);
          },
          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              tooltip: "Главная",
              icon: widget.currentTab == 0
                  ? SvgPicture.asset(
                      'assets/icons/home.svg',
                      color: primary_50,
                    )
                  : SvgPicture.asset(
                      'assets/icons/home.svg',
                      alignment: Alignment.center,
                    ),
              label: widget.currentTab == 0 ? 'Главная' : '',
            ),
            BottomNavigationBarItem(
              tooltip: "Поиск",
              icon: widget.currentTab == 1
                  ? SvgPicture.asset(
                      'assets/icons/search_200.svg',
                      color: primary_50,
                    )
                  : SvgPicture.asset(
                      'assets/icons/search_200.svg',
                    ),
              label: widget.currentTab == 1 ? 'Поиск' : '',
            ),
            BottomNavigationBarItem(
              tooltip: "Корзина",
              icon: widget.currentTab == 2
                  ? SvgPicture.asset('assets/icons/cart_200.svg',
                      color: primary_50)
                  : SvgPicture.asset(
                      'assets/icons/cart_200.svg',
                    ),
              label: widget.currentTab == 2 ? 'Корзина' : '',
            ),
            BottomNavigationBarItem(
              tooltip: "Мои заказы",
              icon: widget.currentTab == 3
                  ? SvgPicture.asset('assets/icons/bag_200.svg',
                      color: primary_50)
                  : SvgPicture.asset('assets/icons/bag_200.svg'),
              label: widget.currentTab == 3 ? 'Мои заказы' : '',
            ),
            BottomNavigationBarItem(
              tooltip: "Профиль",
              icon: widget.currentTab == 4
                  ? SvgPicture.asset('assets/icons/person.svg',
                      color: primary_50)
                  : SvgPicture.asset('assets/icons/person.svg'),
              label: widget.currentTab == 4 ? 'Профиль' : '',
            ),
          ],
        ),
      ),
    );
  }
}
