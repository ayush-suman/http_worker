import 'dart:async';

import 'package:http_worker/src/request_method.dart';
import 'package:http_worker/src/response.dart';
import 'package:parser_interface/parser_interface.dart';

/// This is the base class for all the workers that process the requests.
/// This can be extended to create your own implementation for processing
/// requests.
///
/// For example, you can create a [HttpWorker] that processes requests on a pool
/// of [Isolates](https://www.youtube.com/watch?v=vl_AaCgudcY) with an
/// implementation of load balancer to balance the request across
/// [Isolate](https://www.youtube.com/watch?v=vl_AaCgudcY)s.
abstract class HttpWorker<K> {
  const HttpWorker();

  /// This method is called before any requests are processed. This can be used
  /// to complete any initialisation needed before the worker can call
  /// [processRequest].
  ///
  /// For example, if you are using
  /// [Isolate](https://www.youtube.com/watch?v=vl_AaCgudcY)s to call requests,
  /// spawn the isolates in this function.
  Future init();

  /// Function to process the request. This function should return a [Completer]
  /// with [Response] as the future.
  (Completer<Response<T>>, {Object? meta}) processRequest<T>({
      required K id,
      required RequestMethod method,
      required Uri url,
      Map<String, String>? header,
      Object? body,
      Parser<T>? parser,
      Map<String, Object?> meta = const {}
  });

  /// Function to cancel the request with the given [id].
  Future killRequest(K id);

  /// Function to destroy the worker. Currently, this is not used in this library.
  /// But, you can call this function from your application if you have access
  /// to the [HttpWorker] object to destroy it.
  ///
  /// This is where you can destroy the [Isolate](https://www.youtube.com/watch?v=vl_AaCgudcY)s
  /// if you are using them in your implementation.
  destroy();
}
