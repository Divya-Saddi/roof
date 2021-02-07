import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/album/album.dart';
import 'data/networkRequest.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = SimpleBlocDelegate();
  runApp(MyApp());
}

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Cubit bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlbumBloc>(
        create: (context) => AlbumBloc(mAlbumRepo: AlbumsRepository())..add(FetchNextAlbumListEvent()),
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Roof Demo App',
        home: AlbumHomePage(),
    ));
  }
}

