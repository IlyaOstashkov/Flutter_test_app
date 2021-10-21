// Mocks generated by Mockito 5.0.16 from annotations
// in flutter_test_app/test/unit/art_object_detail_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:test_app_domain/src/models/art_object.dart' as _i2;
import 'package:test_app_domain/src/repository/art_object_repository.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeArtObject_0 extends _i1.Fake implements _i2.ArtObject {}

/// A class which mocks [ArtObjectRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockArtObjectRepository extends _i1.Mock
    implements _i3.ArtObjectRepository {
  MockArtObjectRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.ArtObject>> getArtObjectList(
          {int? page, int? limit, int? century}) =>
      (super.noSuchMethod(
              Invocation.method(#getArtObjectList, [],
                  {#page: page, #limit: limit, #century: century}),
              returnValue: Future<List<_i2.ArtObject>>.value(<_i2.ArtObject>[]))
          as _i4.Future<List<_i2.ArtObject>>);
  @override
  _i4.Future<_i2.ArtObject> getArtObject({String? objectNumber}) => (super
      .noSuchMethod(
          Invocation.method(#getArtObject, [], {#objectNumber: objectNumber}),
          returnValue: Future<_i2.ArtObject>.value(_FakeArtObject_0())) as _i4
      .Future<_i2.ArtObject>);
  @override
  String toString() => super.toString();
}
