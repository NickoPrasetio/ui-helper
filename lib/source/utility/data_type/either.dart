//
//  either.dart
//  Inspire
//
//  Created by Gabriel Sore on 17/04/2024.
//  Copyright © 2024 Allianz. All rights reserved.
//
class Either<L, R> {
  final L left;
  final R right;

  Either(this.left, this.right);

  // Check if Left Value not null
  bool get isLeft => left != null;

  // Check if Right Value not null
  bool get isRight => right != null;

  // Get Left Value
  L? getLeft() => isLeft ? left : null;

  // Get Right Value
  R? getRight() => isRight ? right : null;

  // Check if both are equal (operator overloading)
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Either &&
              runtimeType == other.runtimeType &&
              left == other.left &&
              right == other.right;

  // // Copy with method to copy the either with new values
  copyWith({required L left, required R right}) =>
      Either(left ?? this.left, right ?? this.right);

  @override
  String toString() {
    return "Either{left: $left, right: $right}";
  }

  Either<L, R> setLeft(L left) {
    return Either(left, right);
  }

  Either<L, R> setRight(R right) {
    return Either(left, right);
  }

}

// Left Class
class Left<L> extends Either<L, Null> {
  Left(L left) : super(left, null);
  get value => super.left;
}

// Right Class
class Right<R> extends Either<Null, R> {
  Right(R right) : super(null, right);

  get value => super.right;
}
