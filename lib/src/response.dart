/// This class contains the response details of a request
/// This includes the [status] of the response
/// The [data] or the parsed body of the response
/// The [error] if the request failed or the parsing failed
/// and [hasError] which is true if the [error] is not null
/// and [isCancelled] which is true if the request was cancelled by the user.
/// If the request gets cancelled by the user, the [data] and [error] will
/// be null, and the [status] will be `-1`.
class Response<D> {
  Response(
      {required this.status, this.data, this.error, this.isCancelled = false})
      : hasError = error != null;

  final int status;
  final D? data;
  final bool hasError;
  final Object? error;
  final bool isCancelled;
}