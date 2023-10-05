class AppExceptions implements Exception {
  final _message;
  final _prefix;
  AppExceptions([this._message, this._prefix]);
  @override
  String toString() {
    // TODO: implement toString
    return '${_message}${_prefix}';
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(message, 'ERRO DURING COMMUNICATION');
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message]) : super(message, 'INVALID REQUEST');
}

class UnauthorisedException extends AppExceptions {
  UnauthorisedException([String? message])
      : super(message, 'UNAUTHORISED EXCEPTION');
}

class InputInvalidException extends AppExceptions {
  InputInvalidException([String? message])
      : super(message, 'INPUT INVALID EXCEPTION');
}
