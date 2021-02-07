
import 'package:roof/data/exception.dart';
import 'package:roof/data/model/album.dart';
import 'package:roof/data/networkRequest.dart';

import 'album.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:io';


class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  //
  final AlbumsRepository mAlbumRepo;
  List<AlbumModel> mAlbumList;
  int start = 0;
  bool isFetchingData = false;

  AlbumBloc({this.mAlbumRepo}) : super(AlbumInitialState());


  @override
  Stream<AlbumState> mapEventToState(AlbumEvent event) async* {
    if(event is FetchNextAlbumListEvent){
      yield AlbumLoadingState(message: "Loading albums.... ");
      try {
          mAlbumList = await mAlbumRepo.fetchAlbumList(start);
          print(mAlbumList.length);
          yield AlbumsLoadedState(mAlbumList: mAlbumList);
          start = start+20;
        } on SocketException {
          yield AlbumErrorState(
            error: NetworkErrorException(),
          );
        } catch (e) {
        print(e);
        yield AlbumErrorState(
          error: UnKnownException(),
        );
      }

    }

  }
}





