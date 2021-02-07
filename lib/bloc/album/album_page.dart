


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roof/data/model/album.dart';

import 'album.dart';

class AlbumHomePage extends StatefulWidget {
  @override
  _AlbumHomePageState createState() => _AlbumHomePageState();
}

class _AlbumHomePageState extends State<AlbumHomePage> {
  final List<AlbumModel> _mAlbumList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Albums'),
    ),
    body: Center(
      child: BlocConsumer<AlbumBloc, AlbumState>(
        listener: (context, AlbumState) {
          if (AlbumState is AlbumLoadingState) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(AlbumState.message)));
          } else if (AlbumState is AlbumsLoadedState && AlbumState.mAlbumList.isEmpty) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('No More Albums in List')));
          } else if (AlbumState is AlbumErrorState) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('${AlbumState.error.message}\nTap to Retry.')));
            BlocProvider.of<AlbumBloc>(context).isFetchingData = false;
          }
          return;
        },
        builder: (context, AlbumState) {
          if (AlbumState is AlbumInitialState ||
              AlbumState is AlbumLoadingState && _mAlbumList.isEmpty) {
            return CircularProgressIndicator();
          } else if (AlbumState is AlbumsLoadedState) {
            _mAlbumList.addAll(AlbumState.mAlbumList);
            BlocProvider.of<AlbumBloc>(context).isFetchingData = false;
            Scaffold.of(context).hideCurrentSnackBar();
          } else if (AlbumState is AlbumErrorState && _mAlbumList.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<AlbumBloc>(context)
                      ..isFetchingData = true
                      ..add(FetchNextAlbumListEvent());
                  },
                  icon: Icon(Icons.refresh),
                ),
                const SizedBox(height: 15),
                Text('${AlbumState.error.message}\nTap to Retry.', textAlign: TextAlign.center),
              ],
            );
          }
          return ListView.separated(
            controller: _scrollController
              ..addListener(() {
                if (_scrollController.offset ==
                    _scrollController.position.maxScrollExtent &&
                    !BlocProvider.of<AlbumBloc>(context).isFetchingData) {
                  BlocProvider.of<AlbumBloc>(context)
                    ..isFetchingData = true
                    ..add(FetchNextAlbumListEvent());
                }
              }),
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${_mAlbumList[index].id}  ${_mAlbumList[index].title}"),
//                  Divider(),
                ],
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: _mAlbumList.length,
          );
        },
      ),
    ));
  }

}
