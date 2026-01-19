import 'dart:convert';
import 'package:baby_look/features/feature_generate/domain/prediction_entity.dart';

class PredictionModel {
  final String id;
  final DateTime created;
  final String ownerId;
  final String photoUrl;
  final int gestationWeek;
  final String gender;
  PredictionModel({
    required this.id,
    required this.created,
    required this.ownerId,
    required this.photoUrl,
    required this.gestationWeek,
    required this.gender,
  });

  PredictionModel copyWith({
    String? id,
    DateTime? created,
    String? ownerId,
    String? photoUrl,
    int? gestationWeek,
    String? gender,
  }) {
    return PredictionModel(
      id: id ?? this.id,
      created: created ?? this.created,
      ownerId: ownerId ?? this.ownerId,
      photoUrl: photoUrl ?? this.photoUrl,
      gestationWeek: gestationWeek ?? this.gestationWeek,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created': created.millisecondsSinceEpoch,
      'ownerId': ownerId,
      'photoUrl': photoUrl,
      'gestationWeek': gestationWeek,
      'gender': gender,
    };
  }

  factory PredictionModel.fromEntity(PredictionEntity entity) {
    return PredictionModel(
      id: entity.id,
      created: entity.created,
      ownerId: entity.ownerId,
      photoUrl: entity.photoUrl,
      gestationWeek: entity.gestationWeek,
      gender: entity.gender,
    );
  }

  PredictionEntity toEntity() => PredictionEntity(
    id: id,
    created: created,
    ownerId: ownerId,
    photoUrl: photoUrl,
    gestationWeek: gestationWeek,
    gender: gender,
  );

  factory PredictionModel.fromMap(Map<String, dynamic> map) {
    return PredictionModel(
      id: map['id'] ?? '',
      created: DateTime.fromMillisecondsSinceEpoch(map['created']),
      ownerId: map['ownerId'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      gestationWeek: map['gestationWeek']?.toInt() ?? 0,
      gender: map['gender'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PredictionModel.fromJson(String source) =>
      PredictionModel.fromMap(json.decode(source));
}
