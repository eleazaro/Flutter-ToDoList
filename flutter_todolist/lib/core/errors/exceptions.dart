import 'package:flutter/material.dart';

class CoreException implements Exception {
  CoreException(StackTrace? stackTrace, String? label, dynamic exception) {
    debugPrintStack(label: 'Exception :: $label', stackTrace: stackTrace);
  }
}

class GetTarefasException extends CoreException {
  GetTarefasException(super.stackTrace, super.label, super.exception);
}

class PostTarefasException extends CoreException {
  PostTarefasException(super.stackTrace, super.label, super.exception);
}

class DeleteTarefasException extends CoreException {
  DeleteTarefasException(super.stackTrace, super.label, super.exception);
}

class PutTarefasException extends CoreException {
  PutTarefasException(super.stackTrace, super.label, super.exception);
}
