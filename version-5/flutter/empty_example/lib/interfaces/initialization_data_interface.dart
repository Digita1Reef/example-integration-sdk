class InitializationData {
  final bool success;
  final dynamic data;
  final String? error;
  final String timestamp;

  InitializationData({
    required this.success,
    this.data,
    this.error,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data,
      'error': error,
      'timestamp': timestamp,
    };
  }

  factory InitializationData.fromJson(Map<String, dynamic> json) {
    return InitializationData(
      success: json['success'] ?? false,
      data: json['data'],
      error: json['error'],
      timestamp: json['timestamp'] ?? DateTime.now().toIso8601String(),
    );
  }

  @override
  String toString() {
    return 'InitializationData{success: $success, data: $data, error: $error, timestamp: $timestamp}';
  }
}