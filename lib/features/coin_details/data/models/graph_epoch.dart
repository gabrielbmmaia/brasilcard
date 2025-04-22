import 'package:equatable/equatable.dart';

class GraphEpoch extends Equatable {
  const GraphEpoch({
    required this.now,
    required this.start,
    required this.interval,
  });

  final int now;
  final int start;
  final String interval;

  static int _nowMs() => DateTime.now().millisecondsSinceEpoch;

  static int _subtractDaysMs(int days) {
    final now = DateTime.now();
    final start = now.subtract(Duration(days: days));
    return start.millisecondsSinceEpoch;
  }

  factory GraphEpoch.last30Days() {
    return GraphEpoch(
      now: _nowMs(),
      start: _subtractDaysMs(30),
      interval: 'h6',
    );
  }

  factory GraphEpoch.last90Days() {
    return GraphEpoch(
      now: _nowMs(),
      start: _subtractDaysMs(90),
      interval: 'd1',
    );
  }

  factory GraphEpoch.last180Days() {
    return GraphEpoch(
      now: _nowMs(),
      start: _subtractDaysMs(180),
      interval: 'd1',
    );
  }

  factory GraphEpoch.lastYear() {
    return GraphEpoch(
      now: _nowMs(),
      start: _subtractDaysMs(360),
      interval: 'd1',
    );
  }

  factory GraphEpoch.last2Years() {
    return GraphEpoch(
      now: _nowMs(),
      start: _subtractDaysMs(365 * 2),
      interval: 'd1',
    );
  }

  @override
  List<Object?> get props => [now, start, interval];
}
