import 'dart:convert';

import 'package:baby_look/features/feature_user/domain/user_entity.dart';

class UserModel {
  String id;
  int coins;
  List<String> predictions;
  List<String> favourites;
  UserModel({
    required this.id,
    required this.coins,
    required this.predictions,
    required this.favourites,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'coins': coins,
      'predictions': predictions,
      'favourites': favourites,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      coins: map['coins']?.toInt() ?? 0,
      predictions: (map['predictions'] as List<dynamic>)
          .cast<String>()
          .toList(),
      favourites: (map['favourites'] as List<dynamic>).cast<String>().toList(),
    );
  }

  UserEntity toEntity() => UserEntity(
    id: id,
    coins: coins,
    predictions: predictions,
    favourites: favourites,
  );

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
    id: entity.id,
    coins: entity.coins,
    predictions: entity.predictions,
    favourites: entity.favourites,
  );

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? id,
    int? coins,
    List<String>? predictions,
    List<String>? favourites,
  }) {
    return UserModel(
      id: id ?? this.id,
      coins: coins ?? this.coins,
      predictions: predictions ?? this.predictions,
      favourites: favourites ?? this.favourites,
    );
  }
}
