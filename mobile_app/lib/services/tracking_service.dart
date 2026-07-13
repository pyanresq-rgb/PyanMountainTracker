import 'package:http/http.dart' as http;
import 'dart:convert';

// lib/services/tracking_service.dart

class TrackingService {
  final String baseUrl = 'http://localhost:3000/api';

  // Start tracking session
  Future<Map<String, dynamic>> startSession({
    required int groupId,
    required int createdBy,
    required String name,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sessions/start'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'group_id': groupId,
          'created_by': createdBy,
          'name': name,
          'latitude': latitude,
          'longitude': longitude,
        }),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to start session');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Update location
  Future<void> updateLocation({
    required int userId,
    required String sessionId,
    required double latitude,
    required double longitude,
    double? altitude,
    double? accuracy,
    double? speed,
    double? battery,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tracking/update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'session_id': sessionId,
          'latitude': latitude,
          'longitude': longitude,
          'altitude': altitude,
          'accuracy': accuracy,
          'speed': speed,
          'battery': battery,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update location');
      }
    } catch (e) {
      rethrow;
    }
  }

  // End tracking session
  Future<void> endSession({
    required String sessionId,
    required double endLatitude,
    required double endLongitude,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/sessions/$sessionId/end'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'end_latitude': endLatitude,
          'end_longitude': endLongitude,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to end session');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Get session details
  Future<Map<String, dynamic>> getSessionDetails(String sessionId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/sessions/$sessionId'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get session details');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Get active sessions
  Future<List<dynamic>> getActiveSessions(int groupId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/sessions/group/$groupId/active'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get active sessions');
      }
    } catch (e) {
      rethrow;
    }
  }
}
