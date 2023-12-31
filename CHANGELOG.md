## 0.0.1

- Initial version.

## 0.0.2

- Add `Option<T>` class.

## 0.1.0

- Add `PastelError`, `ExceptionError`, `StringError` class.
- Change `Result<O, E>` to `Result<O>`.
  
## 0.1.1

- Add `example.dart` file.

## 0.2.0

- Add some iterable functions.
- Add `ImmutableList<T>`, `ImmutableMap<T>` class.

## 0.3.0

- Add `Either<L, R>` class.
- Add `cond<T, R>`, `match<T, R>`, `when<T, R>` functions.
- Add `Scope<T>` class.

## 0.3.1

- Fix export path.

## 0.4.0

- Change `Scope<T>.let<R>`'s return type to `R` form `Result<R>`.

## 0.5.0

- Add `mapLeftOr`, `mapRightOr` functions for `Either<L, R>` class.
- Add `mapErr`, `mapErrOr` functions for `Result<T>` class.
- Update `README.md`.

## 0.5.1

- Update `README.md`.

## 0.6.0

- Add `Reactive<T>` class.

## 0.6.1

- Export `Reactive<T>` class.

## 0.6.2

- Add `unlisten` method to `Reactive<T>` class.

## 0.6.3

- Add `notify()` method to `Reactive<T>` class.

## 0.6.4

- Add `set update` property to `Reactive<T>` class.
- Add `OnceReactive<T>` class.

## 0.7.0

- Change return type of `Either<L, R>`'s `map`, `mapLeftOr` and `mapRightOr` functions to `Either<L, R>`.
- Change return type of `Option<T>`'s `map`, `mapOr`, `mapOrElse` function to `Option<R>`.
- Add `Result.tryCatch<T>` constructor.

