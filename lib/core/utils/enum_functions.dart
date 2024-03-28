String enumValueToString(Object? enumValue) =>
    enumValue.toString().split(".").last;

T convertStringToEnum<T>(Iterable<T> values, String? value) =>
    values.firstWhere(
      (type) => enumValueToString(type) == value,
      orElse: () =>
          throw Exception("$value is not part of ${values.first.runtimeType}"),
    );
