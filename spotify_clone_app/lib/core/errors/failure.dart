// ignore_for_file: public_member_api_docs, sort_constructors_first
class Failure {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});

  @override
  String toString() => message;
}
