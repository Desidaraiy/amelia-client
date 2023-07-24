import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/address.dart';
import '../models/favorite.dart';
import '../models/filter.dart';
import '../models/Product.dart';
import '../models/review.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as userRepo;

// Future<Stream<Product>> getTrendingProducts(Address address) async {
//   Uri uri = Helper.getUri('api/products');
//   Map<String, dynamic> _queryParams = {};
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   Filter filter =
//       Filter.fromJSON(json.decode(prefs.getString('filter') ?? '{}'));
//   filter.delivery = false;
//   filter.open = false;
//   _queryParams['limit'] = '6';
//   _queryParams['trending'] = 'week';
//   if (!address.isUnknown()) {
//     _queryParams['myLon'] = address.longitude.toString();
//     _queryParams['myLat'] = address.latitude.toString();
//     _queryParams['areaLon'] = address.longitude.toString();
//     _queryParams['areaLat'] = address.latitude.toString();
//   }
//   _queryParams.addAll(filter.toQuery());
//   uri = uri.replace(queryParameters: _queryParams);
//   try {
//     final client = new http.Client();
//     final streamedRest = await client.send(http.Request('get', uri));

//     return streamedRest.stream
//         .transform(utf8.decoder)
//         .transform(json.decoder)
//         .map((data) => Helper.getData(data))
//         .expand((data) => (data as List))
//         .map((data) {
//       return Product.fromJSON(data);
//     });
//   } catch (e) {
//     print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
//     return new Stream.value(new Product.fromJSON({}));
//   }
// }

String productToJson(Product product) {
  final productMap = product.toMap();
  return jsonEncode(productMap);
}

Future<Stream<Product>> getTrendingProducts() async {
  Uri uri = Helper.getUri('api/products');
  Map<String, dynamic> _queryParams = {};
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Filter filter =
      Filter.fromJSON(json.decode(prefs.getString('filter') ?? '{}'));
  String activeCity = prefs.getString('activeCity');
  filter.delivery = false;
  filter.open = false;
  _queryParams['limit'] = '10';
  _queryParams['sort'] = 'last_ordered';
  _queryParams['f[were_ordered]'] = '1';
  _queryParams['search'] = 'market.address:${activeCity}';

  _queryParams.addAll(filter.toQuery());
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return Product.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Product.fromJSON({}));
  }
}

// Future<Stream<Product>> getProductsByQuery(query) async {
//   Uri uri = Helper.getUri('api/products');
//   Map<String, dynamic> _queryParams = {};
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   Filter filter =
//       Filter.fromJSON(json.decode(prefs.getString('filter') ?? '{}'));
//   String activeCity = prefs.getString('activeCity');
//   filter.delivery = false;
//   filter.open = false;
//   _queryParams['limit'] = '10';
//   _queryParams['f[q]'] = query;
//   _queryParams.addAll(filter.toQuery());
//   uri = uri.replace(queryParameters: _queryParams);
//   try {
//     final client = new http.Client();
//     final streamedRest = await client.send(http.Request('get', uri));
//     return streamedRest.stream
//         .transform(utf8.decoder)
//         .transform(json.decoder)
//         .map((data) => Helper.getData(data))
//         .expand((data) => (data as List))
//         .map((data) {
//       return Product.fromJSON(data);
//     });
//   } catch (e) {
//     print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
//   }
// }

Future<List<Product>> getProductsByQuery(query) async {
  Uri uri = Helper.getUri('api/products');
  Map<String, dynamic> _queryParams = {};
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Filter filter =
      Filter.fromJSON(json.decode(prefs.getString('filter') ?? '{}'));
  String activeCity = prefs.getString('activeCity');
  filter.delivery = false;
  filter.open = false;
  _queryParams['limit'] = '10';
  _queryParams['f[q]'] = query;
  _queryParams.addAll(filter.toQuery());
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      List<Product> products =
          responseData.map((item) => Product.fromJSON(item)).toList();
      return products;
    } else {
      throw Exception('Failed to get products 1');
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    throw Exception('Failed to get products 2');
  }
}

Future<Stream<Product>> getNewInStockProducts() async {
  Uri uri = Helper.getUri('api/products');
  Map<String, dynamic> _queryParams = {};
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Filter filter =
      Filter.fromJSON(json.decode(prefs.getString('filter') ?? '{}'));
  String activeCity = prefs.getString('activeCity');
  filter.delivery = false;
  filter.open = false;
  _queryParams['limit'] = '10';
  _queryParams['sort'] = 'new';
  _queryParams['search'] = 'market.address:${activeCity}';

  _queryParams.addAll(filter.toQuery());
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return Product.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Product.fromJSON({}));
  }
}

Future<Stream<Product>> getProduct(String productId) async {
  Uri uri = Helper.getUri('api/products/$productId');
  uri = uri.replace(queryParameters: {
    'with':
        'market;category;options;optionGroups;productReviews;productReviews.user'
  });
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .map((data) {
      return Product.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: e.toString()).toString());
    return new Stream.value(new Product.fromJSON({}));
  }
}

Future<Product> getProductById(String productId) async {
  Uri uri = Helper.getUri('api/products/$productId');
  uri = uri.replace(queryParameters: {
    'with':
        'market;category;options;optionGroups;productReviews;productReviews.user'
  });
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    // return streamedRest.stream
    //     .transform(utf8.decoder)
    //     .transform(json.decoder)
    //     .map((data) => Helper.getData(data))
    //     .map((data) {
    //   return Product.fromJSON(data);
    // });
    final response = await streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .single;
    return Product.fromJSON(response);
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: e.toString()).toString());
    return new Product.fromJSON({});
  }
}

Future<Stream<Product>> searchProducts(String search, Address address) async {
  Uri uri = Helper.getUri('api/products');
  Map<String, dynamic> _queryParams = {};
  _queryParams['search'] = 'name:$search;description:$search';
  _queryParams['searchFields'] = 'name:like;description:like';
  _queryParams['limit'] = '5';
  if (!address.isUnknown()) {
    _queryParams['myLon'] = address.longitude.toString();
    _queryParams['myLat'] = address.latitude.toString();
    _queryParams['areaLon'] = address.longitude.toString();
    _queryParams['areaLat'] = address.latitude.toString();
  }
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return Product.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Product.fromJSON({}));
  }
}

Future<Stream<Product>> getProductsByCategory(categoryId) async {
  Uri uri = Helper.getUri('api/products');
  Map<String, dynamic> _queryParams = {};
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Filter filter =
      Filter.fromJSON(json.decode(prefs.getString('filter') ?? '{}'));
  _queryParams['with'] = 'market';
  _queryParams['search'] = 'category_id:$categoryId';
  _queryParams['searchFields'] = 'category_id:=';

  _queryParams = filter.toQuery(oldQuery: _queryParams);
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return Product.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Product.fromJSON({}));
  }
}

Future<Stream<Favorite>> isFavoriteProduct(String productId) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return Stream.value(null);
  }
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}favorites/exist?${_apiToken}product_id=$productId&user_id=${_user.id}';
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getObjectData(data))
        .map((data) => Favorite.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new Favorite.fromJSON({}));
  }
}

Future<bool> isInFavs(String productId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final favorites = prefs.getStringList('favorites') ?? [];
  for (final item in favorites) {
    final json = jsonDecode(item);
    final _productId = json['id'].toString();
    if (_productId == productId.toString()) {
      return true; // товар есть в избранном
    }
  }
  return false;
}

Future<Stream<Favorite>> getFavorites() async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return Stream.value(null);
  }
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}favorites?${_apiToken}with=product;user;options&search=user_id:${_user.id}&searchFields=user_id:=';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));
  try {
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Favorite.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new Favorite.fromJSON({}));
  }
}

Future<List<Product>> getFavoritesLocal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final favorites = prefs.getStringList('favorites') ?? [];
  List<Product> _favs = [];
  int limit = favorites.length < 5 ? favorites.length : 5;
  for (int i = limit - 1; i >= 0; i--) {
    final json = jsonDecode(favorites[i]);
    final Product _fav = Product.fromJSON(json);
    _favs.add(_fav);
  }
  return _favs;
}

Future<bool> addFavorite(Product product) async {
  // User _user = userRepo.currentUser.value;
  // if (_user.apiToken == null) {
  //   return new Favorite();
  // }
  // final String _apiToken = 'api_token=${_user.apiToken}';
  // favorite.userId = _user.id;
  // final String url =
  //     '${GlobalConfiguration().getValue('api_base_url')}favorites?$_apiToken';
  // try {
  //   final client = new http.Client();
  //   final response = await client.post(
  //     Uri.parse(url),
  //     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //     body: json.encode(favorite.toMap()),
  //   );
  //   return Favorite.fromJSON(json.decode(response.body)['data']);
  // } catch (e) {
  //   print(CustomTrace(StackTrace.current, message: url).toString());
  //   return Favorite.fromJSON({});
  // }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final favorites = prefs.getStringList('favorites') ?? [];
  final productId = product.id.toString();
  for (final item in favorites) {
    final json = jsonDecode(item);
    final productId = json['id'].toString();
    if (productId == product.id.toString()) {
      return false; // товар уже добавлен в избранное
    }
  }
  final productJson = productToJson(product);
  favorites.add(productJson);
  await prefs.setStringList('favorites', favorites);
  return true;
}

Future<bool> removeFavorite(String productId) async {
  // User _user = userRepo.currentUser.value;
  // if (_user.apiToken == null) {
  //   return new Favorite();
  // }
  // final String _apiToken = 'api_token=${_user.apiToken}';
  // final String url =
  //     '${GlobalConfiguration().getValue('api_base_url')}favorites/${favorite.id}?$_apiToken';
  // try {
  //   final client = new http.Client();
  //   final response = await client.delete(
  //     Uri.parse(url),
  //     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //   );
  //   return Favorite.fromJSON(json.decode(response.body)['data']);
  // } catch (e) {
  //   print(CustomTrace(StackTrace.current, message: url).toString());
  //   return Favorite.fromJSON({});
  // }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final favorites = prefs.getStringList('favorites') ?? [];
  for (int i = 0; i < favorites.length; i++) {
    final item = favorites[i];
    final json = jsonDecode(item);
    final _productId = json['id'].toString();
    if (_productId == productId.toString()) {
      favorites.removeAt(i);
      await prefs.setStringList('favorites', favorites);
      return true; // товар был удален из избранного
    }
  }
  return false;
}

Future<Stream<Product>> getProductsOfMarket(String marketId,
    {List<String> categories}) async {
  Uri uri = Helper.getUri('api/products/categories');
  Map<String, dynamic> query = {
    'with': 'market;category;options;productReviews',
    'search': 'market_id:$marketId',
    'searchFields': 'market_id:=',
  };

  if (categories != null && categories.isNotEmpty) {
    query['categories[]'] = categories;
  }
  uri = uri.replace(queryParameters: query);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return Product.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Product.fromJSON({}));
  }
}

Future<Stream<Product>> getTrendingProductsOfMarket(String marketId) async {
  Uri uri = Helper.getUri('api/products');
  uri = uri.replace(queryParameters: {
    'with': 'category;options;productReviews',
    'search': 'market_id:$marketId;featured:1',
    'searchFields': 'market_id:=;featured:=',
    'searchJoin': 'and',
  });
  // TODO Trending products only
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return Product.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Product.fromJSON({}));
  }
}

Future<Stream<Product>> getFeaturedProductsOfMarket(String marketId) async {
  Uri uri = Helper.getUri('api/products');
  uri = uri.replace(queryParameters: {
    'with': 'category;options;productReviews',
    'search': 'market_id:$marketId;featured:1',
    'searchFields': 'market_id:=;featured:=',
    'searchJoin': 'and',
  });
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return Product.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Product.fromJSON({}));
  }
}

Future<Review> addProductReview(Review review, Product product) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}product_reviews';
  final client = new http.Client();
  review.user = userRepo.currentUser.value;
  try {
    final response = await client.post(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(review.ofProductToMap(product)),
    );
    if (response.statusCode == 200) {
      return Review.fromJSON(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return Review.fromJSON({});
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return Review.fromJSON({});
  }
}
