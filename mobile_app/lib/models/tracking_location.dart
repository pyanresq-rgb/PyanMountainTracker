// lib/models/tracking_location.dart

class TrackingLocation {
  final int id;
  final int userId;
  final String sessionId;
  final double latitude;
  final double longitude;
  final double? altitude;
  final double? accuracy;
  final double? speed;
  final double? battery;
  final DateTime timestamp;
  final String? userName;

  TrackingLocation({
    required this.id,
    required this.userId,
    required this.sessionId,
    required this.latitude,
    required this.longitude,
    this.altitude,
    this.accuracy,
    this.speed,
    this.battery,
    required this.timestamp,
    this.userName,
  });

  factory TrackingLocation.fromJson(Map<String, dynamic> json) {
    return TrackingLocation(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      sessionId: json['session_id'] ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      altitude: json['altitude'] != null ? (json['altitude'] as num).toDouble() : null,
      accuracy: json['accuracy'] != null ? (json['accuracy'] as num).toDouble() : null,
      speed: json['speed'] != null ? (json['speed'] as num).toDouble() : null,
      battery: json['battery'] != null ? (json['battery'] as num).toDouble() : null,
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      userName: json['user_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'session_id': sessionId,
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
      'accuracy': accuracy,
      'speed': speed,
      'battery': battery,
    };
  }
}
