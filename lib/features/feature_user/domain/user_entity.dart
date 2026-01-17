import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  String id;
  int coins;
  List<String> predictions;
  List<String> favourites;
  UserEntity({
    required this.id,
    required this.coins,
    required this.predictions,
    required this.favourites,
  });

  @override
  List<Object?> get props => [id,coins,predictions,favourites];
}
