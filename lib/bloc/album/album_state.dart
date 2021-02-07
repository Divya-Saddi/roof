

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:roof/data/model/album.dart';

abstract class AlbumState extends Equatable {
//  final List<AlbumModel> mAlbumList;
//  final bool hasReachedEndOfAlbum;
//  AlbumState({this.mAlbumList,this.hasReachedEndOfAlbum});
}

class AlbumInitialState extends AlbumState {
  @override
  String toString() => 'Album Initial State';

  @override
  List<Object> get props => [];
}

class AlbumLoadingState extends AlbumState {
  final String message;

  AlbumLoadingState({this.message});

  @override
  String toString() => 'Album loading.. State';

  @override
  List<Object> get props => [];
}

class AlbumsLoadedState extends AlbumState {
  final List<AlbumModel> mAlbumList;

  AlbumsLoadedState({this.mAlbumList});

  @override
  String toString() =>
      'Albums Loaded { albums: ${mAlbumList.length}}';

  @override
  List<Object> get props => [];
}

class AlbumErrorState extends AlbumState {
  final  error;
  AlbumErrorState({this.error});


  @override
  String toString() => 'Album Error State';

  @override
  List<Object> get props => [];
}