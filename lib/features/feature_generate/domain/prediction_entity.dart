class PredictionEntity {
  final String id;
  final DateTime created;
  final String ownerId;
  final String photoUrl;
  final int gestationWeek;
  final String gender;
  PredictionEntity({
    required this.id,
    required this.created,
    required this.ownerId,
    required this.photoUrl,
    required this.gestationWeek,
    required this.gender,
  });
  
}
