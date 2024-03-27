abstract class Usecase<SuccessType, Params> {
  Future<SuccessType> call(Params params);
}
