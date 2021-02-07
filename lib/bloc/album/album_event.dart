
import 'package:equatable/equatable.dart';

abstract class AlbumEvent extends Equatable {}

class FetchNextAlbumListEvent extends AlbumEvent {

  @override
  String toString() => 'Fetch the next list of albums';

  @override
  List<Object> get props => [];
}