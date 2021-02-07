


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

  Widget albumInfo(AlbumModel mAlbumObject) => Card(
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
    ),
    margin: EdgeInsets.fromLTRB(16,24,16,4),
    child : IntrinsicHeight(
        child:Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin:  EdgeInsets.all(16),
                decoration: BoxDecoration(
                    image:DecorationImage(
                      image: new AssetImage('assets/images/placeholder.png'),fit: BoxFit.cover,),
                    borderRadius: new BorderRadius.all(new Radius.circular(3))),
                height: 80,width:80,
              ),
              Expanded(child:Container(
                alignment:Alignment.centerLeft,
//                margin:  EdgeInsets.all(16),
                child: Text(mAlbumObject.title),
              )),
              SizedBox(width:16),
            ]
        )
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
          }

          else if (AlbumState is AlbumsLoadedState) {
            _mAlbumList.addAll(AlbumState.mAlbumList);
            BlocProvider.of<AlbumBloc>(context).isFetchingData = false;
            Scaffold.of(context).hideCurrentSnackBar();
          }

          else if (AlbumState is AlbumErrorState && _mAlbumList.isEmpty) {
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
                Text('${AlbumState.error.message}', textAlign: TextAlign.center),
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
            itemBuilder: (context, index) => albumInfo(_mAlbumList[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: _mAlbumList.length,
          );
        },
      ),
    ));
  }

}
