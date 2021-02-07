

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:roof/data/server_strings.dart';

import 'model/album.dart';

Dio dio = new Dio();
const _statusOK = 200;
const _albumLimitPerPage = 20;
final Map<String, String> _jsonHeaders = {'content-type': 'application/json'};

class AlbumsRepository {

  Future<List<AlbumModel>> fetchAlbumList(int index) async{
      Response response = await dio.get("${ServerStrings.albums}?_start=$index&_limit=$_albumLimitPerPage");
      if(response.statusCode == _statusOK){
        AlbumNetworkResponse mResponse = AlbumNetworkResponse.fromJson(response.data);
        return mResponse.mAlbumList;
      }
  }
//  Future<List<AlbumModel>> fetchAlbumList(int index);
}

//class FetchAlbumService implements AlbumsRepository {
//  @override
//
//}


//class BeerRepository {
//  static final BeerRepository _beerRepository = BeerRepository._();
//  static const int _perPage = 10;
//
//  BeerRepository._();
//
//  factory BeerRepository() {
//    return _beerRepository;
//  }
//
//  Future<dynamic> getBeers({
//    @required int page,
//  }) async {
//    try {
//      return await http.get(
//        'https://api.punkapi.com/v2/beers?page=$page&per_page=$_perPage',
//      );
//    } catch (e) {
//      return e.toString();
//    }
//  }
//}
//

