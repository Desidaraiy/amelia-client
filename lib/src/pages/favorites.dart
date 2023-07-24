import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/elements/DrawerWidget.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/models/favorite.dart';
import 'package:markets/src/models/route_argument.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:markets/src/components/EmptyFavoritesWidget.dart';

import '../../generated/l10n.dart';
import '../controllers/favorite_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/FavoriteGridItemWidget.dart';
import '../elements/FavoriteListItemWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../repository/user_repository.dart';

class FavoritesWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  const FavoritesWidget({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _FavoritesWidgetState createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends StateMVC<FavoritesWidget> {
  String layout = 'grid';

  FavoriteController _con;

  _FavoritesWidgetState() : super(FavoriteController()) {
    _con = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      drawer: DrawerWidget(),
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primary_50,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: SvgPicture.asset(
            'assets/icons/navigate_before_200.svg',
            color: primary_700,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).favorites,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: currentUser.value.apiToken == null
          ? PermissionDeniedWidget()
          : RefreshIndicator(
              onRefresh: _con.refreshFavorites,
              child: Stack(children: [
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        if (_con.favorites.isEmpty &&
                            _con.status == LoadingStatus.empty)
                          EmptyFavoritesWidget(),
                        if (_con.status == LoadingStatus.loading &&
                            _con.favorites.isEmpty)
                          CircularLoadingWidget(
                              height: MediaQuery.of(context).size.height * 0.65)
                        else if (_con.status == LoadingStatus.loaded)
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: _con.favorites.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 10);
                            },
                            itemBuilder: (context, index) {
                              return FavoriteListItemWidget(
                                heroTag: 'favorites_list',
                                favorite: _con.favorites.elementAt(index),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
    );
  }
}
