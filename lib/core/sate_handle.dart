class StateHandle<Data> {
  final Data? data;
  final String? message;
  final Status status;

  StateHandle._(this.data, this.message, this.status);

  factory StateHandle.loading() => StateHandle._(null, null, Status.loading);
  factory StateHandle.success(Data data) => StateHandle._(data, null, Status.success);
  factory StateHandle.error(String msg) => StateHandle._(null, msg, Status.error);
}

enum Status { loading, success, error }
