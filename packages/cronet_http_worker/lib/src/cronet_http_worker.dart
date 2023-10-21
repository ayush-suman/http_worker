import 'dart:async';

import 'package:cronet_http/cronet_http.dart';
import 'package:http_worker/http_worker.dart';

class CronetHttpWorker extends HttpWorker {
  @override
  Future init() async {}


  @override
  (Completer<Response<T>>, {Object? meta}) processRequest<T>({required id, required RequestMethod method, required Uri url, Map<String, String>? header, Object? body, Parser<T>? parser, Map<String, Object?>? meta}) {
    CronetClient client = CronetClient.defaultCronetEngine();
    Completer<Response<T>> completer = Completer<Response<T>>();
    client.get(url).then((value) {
      if (parser != null) {
        completer.complete(Response<T>(data: parser.parse(value.body), status: value.statusCode));
      }
      completer.complete(Response<T>(data: value.body as T, status: value.statusCode));
    });
    return (completer, meta: null);
  }

  @override
  Future killRequest(id) {
    // TODO: implement killRequest
    throw UnimplementedError();
  }

  @override
  destroy() {}

}