int getDifferentDay({required DateTime? creationTime}) {
  if (creationTime == null) {
    return 0;
  }

  final today = DateTime.now();
  return today.difference(creationTime).inDays + 1;
}
