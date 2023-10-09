# Pastel

## Description

A library set for convinient code writing.

## Installation

```bash
dart pub add pastel
```

## Backgroud

I like lisp. But I can't adapt to the syntax of lisp. So I write this library to make dart more like lisp.

## Usage

Pastel is a coding style library. It provides a set of functions to make your code more funny.

### Monad

`Monad` is some types for chaining functions.

#### Option<T>

`Option<T>` is a type that can be null.

```dart
import 'package:pastel/pastel.dart';

void main() {
  Option<int> some = Some(1); // Some is a constructor of Option contains value.
  Option<int> none =
      None(); // None is a constructor of Option contains nothing.

  some = some.map((p) => p + 1); // map is a function to transform value.
  none = none.map((p) => p + 1); // none is still none.

  if (some.isSome()) {
    // isSome is a function to check if Option contains value.
    print(some.unwrap()); // unwrap is a function to get value from Option.
  }

  if (none.isNone()) {
    // isNone is a function to check if Option contains nothing.
    try {
      print(none.unwrap()); // unwrap is a function to get value from Option.
    } catch (e) {
      print(e); // unwrap from none will throw error.
    }
  }
}
```

```
2
Exception: Cannot unwrap None

Exited.s
```

#### Either<L, R>

`Either<L, R>` is a type that can be left or right. It is usually used to handle union types.

```dart
import 'package:pastel/pastel.dart';

void main() {
  Either<String, int> left =
      Left('left'); // Left is a subclass of Either containing a value of type A
  Either<String, int> right =
      Right(1); // Right is a subclass of Either containing a value of type B

  left = left.map((lv) => '$lv $lv',
      (rv) => rv * 2); // map() applies a function to the value of the Either
  right = right.map((lv) => '$lv $lv', (rv) => rv * 2);

  if (left.isLeft()) {
    // isLeft() returns true if the Either is a Left
    print(left.unwrapLeft()); // unwrapLeft() returns the value of the Left
  }

  if (right.isRight()) {
    // isRight() returns true if the Either is a Right
    print(right.unwrapRight()); // unwrapRight() returns the value of the Right
  }
}
```

```bash
left left
2

Exited.
```

#### Result<T>

`Result<T>` is a type that can be `Ok<T>` or `Err`.

- `Ok<T>` is a type that contains a value.
- `Err<T>` is a type that contains a error.

```dart
import 'package:pastel/pastel.dart';

void main() {
  Result<int> ok = Ok(123); // Ok<T>() is a class for successful results
  Result<int> err =
      Err(StringError('error message')); // Err<T>() is a class for errors

  ok = ok.map((p) => Ok(p * 200)); // map() applies a function to the value
  err = err.map((p) => Ok(p * 200)); // map() does nothing to errors

  if (ok.isOk()) {
    // isOk() returns true if the result is Ok<T>()
    print(ok.unwrap()); // unwrap() returns the value of Ok<T>()
  }
  if (err.isErr()) {
    // isErr() returns true if the result is Err<T>()
    print(err.unwrapErr()); // unwrapErr() returns the error of Err<T>()
  }
}
```

#### PastelError

`pastelError` is a abstract class for errors.

```dart
import 'package:pastel/pastel.dart';

class CustomError extends PastelError {
  final String message;

  CustomError(this.message);

  @override
  String toString() => message;
}
```

Above is a custom error example.

And bellow is a example using `Result<T>` and `PastelError`.

```dart
import 'dart:io';

import 'package:pastel/pastel.dart';

class FileNotExistsError extends PastelError {
  final String path;

  FileNotExistsError(this.path);

  @override
  String toString() => 'File $path does not exist';
}

class FileSystemError extends PastelError {
  final FileSystemException exception;

  FileSystemError(this.exception);

  @override
  String toString() => exception.toString();
}

void main() {
  const filename = 'pubspec.yaml';
  var result = Ok(File(filename)).map((file) {
    if (file.existsSync()) {
      return Ok(file);
    } else {
      return Err<File>(FileNotExistsError(file.path));
    }
  }).map((file) {
    try {
      return Ok(file.readAsStringSync());
    } on FileSystemException catch (e) {
      return Err<String>(FileSystemError(e));
    }
  });

  switch (result) {
    case Ok<String>():
      print(result.unwrap());
      break;
    case Err<String>():
      print(result.unwrapErr());
      break;
  }
}
```

### Scope

`Scope` is a function that contains some variables using in the scope.

```dart
import 'package:pastel/pastel.dart';

void main() => Scope((a: 50, b: 50)); 
// Scope constructor takes any type.
// But it is recommended to use Tuple type.
```

#### let

`let` method is a method that can use the variables in the scope.

```dart
import 'package:pastel/pastel.dart';

void main() => Scope((a: 50, b: 50)).let((p) => print(p.a + p.b));
// let method's argument is a function that takes the scope as an argument.
// When Scope was reveiced Name Tuple, let can use the named variables like that.
```

```bash
100

Exited.
```

### Iterable

`Iterable` is a set of functions for `Iterable<T>` type.

#### numbers

`numbers` is a function that returns a `Iterable<int>` from `start` to `end` with `[step]`.

```dart
import 'package:pastel/pastel.dart';

void main() => Scope((start: 0, end: 100))
    .let((p) => Some(
        numbers(p.start, p.end).reduce((value, element) => value + element)))
    .map((p) => print(p));
```

```bash
5050

Exited.
```

### Logical

`Logical` is a set of functions for logical operations.

#### cond

`cond` is a compare function that returns `R` type.

```dart
import 'package:pastel/pastel.dart';

final compareTo100 = cond<int, String>([
  ((p0) => p0 < 100, (p0) => 'under 100'),
  ((p0) => p0 > 100, (p0) => 'over 100')
], (p0) => 'equual 100'); // cond takes a list of tuple of compare function and result function.

void main() => Scope((count: 1000))
    .let((p) => Some(compareTo100(p.count))) // use closure to pass the value.
    .map((p0) => print(p0));
```

#### match

`match` is a compare function that recongnizes true or false and returns `R` type.

```dart
import 'package:pastel/pastel.dart';

final compareTo100 = match<int, String>(
    (p0) => p0 == 100, (p0) => 'is 100', (p0) => 'is not 100');
    // match takes a compare function and result function.

void main() => Scope((count: 1000))
    .let((p) => Some(compareTo100(p.count))) // use closure to pass the value.
    .map((p0) => print(p0));
```

#### when

`when` is a compare function that recongnizes equality and returns `R` type.

```dart
import 'package:pastel/pastel.dart';

final compareWith = when<int, String>([
  (100, (p0) => 'equal 100'),
  (200, (p0) => 'equal 200'),
  (300, (p0) => 'equal 300'),
  (400, (p0) => 'equal 400'),
  (500, (p0) => 'equal 500'),
  (600, (p0) => 'equal 600'),
  (700, (p0) => 'equal 700'),
  (800, (p0) => 'equal 800'),
  (900, (p0) => 'equal 900')
], (p0) => 'not equal 100~900');

void main() => Scope((count: 100))
    .let((p) => Some(compareWith(p.count)))
    .map((p0) => print(p0));
```

## Example

A example reading a file

```dart
import 'dart:io';

import 'package:pastel/pastel.dart';

class FileNotExistsError extends PastelError {
  final String path;

  FileNotExistsError(this.path);

  @override
  String toString() => 'File $path does not exist';
}

class FileSystemError extends PastelError {
  final FileSystemException exception;

  FileSystemError(this.exception);

  @override
  String toString() => exception.toString();
}

void main() => Scope((filename: "pubspec.yaml"))
    .let((p) => Ok(File(p.filename)).map((file) {
          if (file.existsSync()) {
            return Ok(file);
          } else {
            return Err<File>(FileNotExistsError(file.path));
          }
        }).map((file) {
          try {
            return Ok(file.readAsStringSync());
          } on FileSystemException catch (e) {
            return Err<String>(FileSystemError(e));
          }
        }).map((content) => Ok(print(content))));
```