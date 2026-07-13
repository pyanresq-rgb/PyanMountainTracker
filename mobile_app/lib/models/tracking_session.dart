// lib/models/tracking_session.dart

class TrackingSession {
  final String sessionId;
  final int groupId;
  final int createdBy;
  final String? name;
  final String? description;
  final String status;
  final double? totalDistanceKm;
  final int? totalTimeMinutes;
  final int participantsCount;
  final DateTime startTime;
  final DateTime? endTime;
  final String? createdByName;

  TrackingSession({
    required this.sessionId,
    required this.groupId,
    required this.createdBy,
    this.name,
    this.description,
    required this.status,
    this.totalDistanceKm,
    this.totalTimeMinutes,
    required this.participantsCount,
    required this.startTime,
    this.endTime,
    this.createdByName,
  });

  factory TrackingSession.fromJson(Map<String, dynamic> json) {
    return TrackingSession(
      sessionId: json['session_id'] ?? '',
      groupId: json['group_id'] ?? 0,
      createdBy: json['created_by'] ?? 0,
      name: json['name'],
      description: json['description'],
      status: json['status'] ?? 'active',
      totalDistanceKm: json['total_distance_km'] != null 
        ? (json['total_distance_km'] as num).toDouble() 
        : null,
      totalTimeMinutes: json['total_time_minutes'],
      participantsCount: json['participants_count'] ?? 1,
      startTime: DateTime.parse(json['start_time'] ?? DateTime.now().toIso8601String()),
      endTime: json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      createdByName: json['created_by_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'group_id': groupId,
      'created_by': createdBy,
      'name': name,
      'description': description,
      'status': status,
    };
  }

  bool get isActive => status == 'active';
  bool get isEnded => status == 'ended';
}
