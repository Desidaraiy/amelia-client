import 'package:flutter/material.dart';
import 'package:markets/src/controllers/map_controller.dart';
import 'package:markets/src/helpers/helper.dart';
import 'package:markets/src/repository/settings_repository.dart';

import '../elements/CardsCarouselLoaderWidget.dart';
import '../models/market.dart';
import '../models/route_argument.dart';
import 'CardWidget.dart';
import '../../generated/l10n.dart';

// ignore: must_be_immutable
class CardsCarouselWidget extends StatefulWidget {
  List<Market> marketsList;
  String heroTag;

  CardsCarouselWidget({Key key, this.marketsList, this.heroTag})
      : super(key: key);

  @override
  _CardsCarouselWidgetState createState() => _CardsCarouselWidgetState();
}

class _CardsCarouselWidgetState extends State<CardsCarouselWidget> {
  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //widget.marketsList.forEach((element) {print(element.name);});
    return widget.marketsList.isEmpty
        ? CardsCarouselLoaderWidget()
        : Container(
            height: 288,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.marketsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Details',
                          arguments: RouteArgument(
                            id: '0',
                            param: widget.marketsList.elementAt(index).id,
                            heroTag: widget.heroTag,
                          ));
                    },
                    child: Helper.canDelivery(
                            widget.marketsList.elementAt(index))
                        ? CardWidget(
                            market: widget.marketsList.elementAt(index),
                            heroTag: widget.heroTag,
                            delivery_or_pickup: Text(
                              S.of(context).delivery_and_pickup,
                              style: Theme.of(context).textTheme.caption.merge(
                                  TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            ),
                          )
                        : CardWidget(
                            market: widget.marketsList.elementAt(index),
                            heroTag: widget.heroTag,
                      delivery_or_pickup: Text(
                              S.of(context).pickup,
                              style: Theme.of(context).textTheme.caption.merge(
                                  TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            ),
                          ));
                ;
              },
            ),
          );
  }
}
