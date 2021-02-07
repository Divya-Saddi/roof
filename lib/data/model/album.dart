

import 'package:flutter/material.dart';


class AlbumNetworkResponse{

  List<AlbumModel> mAlbumList = new List();

  AlbumNetworkResponse({this.mAlbumList});

  AlbumNetworkResponse.fromJson(json) {
    json.forEach((element) {
      mAlbumList.add(new AlbumModel.fromJson(element));
    });
  }
}

class AlbumModel {
   num id;
   num userId;
   String title;


  AlbumModel({this.id, this.userId, this.title});

  AlbumModel.fromJson(json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }

   @override
   String toString() => 'Album { id: $id }';

}







