class ResponseResult {
  final int code;
  final String message;
  final String timestamp;
  final bool result;
  final bool modified;
  final Map<String, dynamic> data;

  ResponseResult(
      {required this.code,
      required this.message,
      required this.timestamp,
      required this.result,
      required this.modified,
      required this.data});

  factory ResponseResult.fromMap(Map<String, dynamic> map) {
    return ResponseResult(
      code: map['code'],
      message: map['message'],
      timestamp: map['timestamp'],
      result: map['result'],
      modified: map['modified'],
      data: map['data'],
    );
  }
}
