

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
}


