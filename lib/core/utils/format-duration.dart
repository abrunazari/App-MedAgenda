String formatDuration(int duration) {
  if (duration < 60) {
    return '$duration min';
  } else {
    final hours = duration ~/ 60;
    final minutes = duration % 60;
    return minutes > 0
        ? '${hours}h${minutes.toString().padLeft(2, '0')}'
        : '${hours}h';
  }
}
