import 'package:equatable/equatable.dart';

abstract class MovieEvent {
  const MovieEvent();
}

class MovieFetchData extends MovieEvent {}

class MovieFetchDetailsData extends MovieEvent {
  final int id;

  MovieFetchDetailsData({required this.id});
}
