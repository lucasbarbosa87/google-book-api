import 'package:result_dart/result_dart.dart';

abstract class BaseUsecase<Input, Output extends Object> {
  AsyncResult<Output, Exception> call(Input param);
}

abstract class BaseUsecaseNoParam<Output extends Object> {
  AsyncResult<Output, Exception> call();
}

abstract class BaseUsecaseParam<Input extends Object> {
  AsyncResult<Unit, Exception> call(Input param);
}

abstract class BaseUsecaseVoid {
  AsyncResult<Unit, Exception> call();
}
