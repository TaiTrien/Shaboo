import 'package:shaboo/data/models/model.dart';

class Response implements Model {
  int _statusCode;
  String _apiMessage;
  dynamic _data;
  dynamic _token;
  dynamic _meta;

  Response.map(dynamic obj) {
    this._statusCode = obj["status"];
    this._apiMessage = obj["message"];
    this._data = obj["data"];
    this._token = obj["token"];
    this._meta = obj["meta"];
  }

  int get statusCode => this._statusCode;
  String get apiMessagse => this._apiMessage;
  dynamic get data => this._data;
  dynamic get token => this._token;
  dynamic get meta => this._meta;

  Map<String, dynamic> toJson() => {
        'statusCode': _statusCode,
        'message': _apiMessage,
        'data': _data,
        'token': _token,
        'meta': _meta,
      };
}
