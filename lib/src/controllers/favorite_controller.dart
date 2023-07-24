import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/favorite.dart';
import '../repository/product_repository.dart';

enum LoadingStatus { loading, loaded, empty, pure }

class FavoriteController extends ControllerMVC {
  List<Favorite> favorites = <Favorite>[];

  LoadingStatus status = LoadingStatus.pure;
  GlobalKey<ScaffoldState> scaffoldKey;

  FavoriteController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();

    listenForFavorites();
    status = LoadingStatus.loading;
  }

  void listenForFavorites({String message}) async {
    final Stream<Favorite> stream = await getFavorites();

    stream.listen((Favorite _favorite) {
      setState(() {
        favorites.add(_favorite);
      });
    }, onError: (a) {
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).verify_your_internet_connection),
      ));
    }, onDone: () {
      setState(() {
        if (favorites.isNotEmpty) {
          status = LoadingStatus.loaded;
          print(status);
        }
        if (favorites.isEmpty) {
          status = LoadingStatus.empty;
          print(status);
        }
      });
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  Future<void> refreshFavorites() async {
    favorites.clear();
    listenForFavorites(
        message: S.of(state.context).favorites_refreshed_successfuly);
  }
}
