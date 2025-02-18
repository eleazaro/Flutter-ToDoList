// Mocks generated by Mockito 5.4.5 from annotations
// in flutter_todolist/test/domain/services/get_tarefas_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:flutter_todolist/core/errors/failures.dart' as _i6;
import 'package:flutter_todolist/domain/entities/tarefa_entity.dart' as _i7;
import 'package:flutter_todolist/domain/repositories/itarefa_repository.dart'
    as _i2;
import 'package:flutter_todolist/domain/services/delete_tarefas_service.dart'
    as _i8;
import 'package:flutter_todolist/domain/services/get_tarefas_service.dart'
    as _i4;
import 'package:flutter_todolist/domain/services/post_tarefas_service.dart'
    as _i9;
import 'package:flutter_todolist/domain/services/put_tarefas_service.dart'
    as _i10;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeITarefaRepository_0 extends _i1.SmartFake
    implements _i2.ITarefaRepository {
  _FakeITarefaRepository_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [GetTarefasService].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTarefasService extends _i1.Mock implements _i4.GetTarefasService {
  MockGetTarefasService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ITarefaRepository get repository =>
      (super.noSuchMethod(
            Invocation.getter(#repository),
            returnValue: _FakeITarefaRepository_0(
              this,
              Invocation.getter(#repository),
            ),
          )
          as _i2.ITarefaRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TarefaEntity>>> call() =>
      (super.noSuchMethod(
            Invocation.method(#call, []),
            returnValue: _i5.Future<
              _i3.Either<_i6.Failure, List<_i7.TarefaEntity>>
            >.value(
              _FakeEither_1<_i6.Failure, List<_i7.TarefaEntity>>(
                this,
                Invocation.method(#call, []),
              ),
            ),
          )
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.TarefaEntity>>>);
}

/// A class which mocks [DeleteTarefaService].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteTarefaService extends _i1.Mock
    implements _i8.DeleteTarefaService {
  MockDeleteTarefaService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ITarefaRepository get repository =>
      (super.noSuchMethod(
            Invocation.getter(#repository),
            returnValue: _FakeITarefaRepository_0(
              this,
              Invocation.getter(#repository),
            ),
          )
          as _i2.ITarefaRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, Null>> call(int? id) =>
      (super.noSuchMethod(
            Invocation.method(#call, [id]),
            returnValue: _i5.Future<_i3.Either<_i6.Failure, Null>>.value(
              _FakeEither_1<_i6.Failure, Null>(
                this,
                Invocation.method(#call, [id]),
              ),
            ),
          )
          as _i5.Future<_i3.Either<_i6.Failure, Null>>);
}

/// A class which mocks [PostTarefaService].
///
/// See the documentation for Mockito's code generation for more information.
class MockPostTarefaService extends _i1.Mock implements _i9.PostTarefaService {
  MockPostTarefaService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ITarefaRepository get repository =>
      (super.noSuchMethod(
            Invocation.getter(#repository),
            returnValue: _FakeITarefaRepository_0(
              this,
              Invocation.getter(#repository),
            ),
          )
          as _i2.ITarefaRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, Null>> call(_i7.TarefaEntity? tarefa) =>
      (super.noSuchMethod(
            Invocation.method(#call, [tarefa]),
            returnValue: _i5.Future<_i3.Either<_i6.Failure, Null>>.value(
              _FakeEither_1<_i6.Failure, Null>(
                this,
                Invocation.method(#call, [tarefa]),
              ),
            ),
          )
          as _i5.Future<_i3.Either<_i6.Failure, Null>>);
}

/// A class which mocks [PutTarefaService].
///
/// See the documentation for Mockito's code generation for more information.
class MockPutTarefaService extends _i1.Mock implements _i10.PutTarefaService {
  MockPutTarefaService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ITarefaRepository get repository =>
      (super.noSuchMethod(
            Invocation.getter(#repository),
            returnValue: _FakeITarefaRepository_0(
              this,
              Invocation.getter(#repository),
            ),
          )
          as _i2.ITarefaRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, Null>> call(_i7.TarefaEntity? tarefa) =>
      (super.noSuchMethod(
            Invocation.method(#call, [tarefa]),
            returnValue: _i5.Future<_i3.Either<_i6.Failure, Null>>.value(
              _FakeEither_1<_i6.Failure, Null>(
                this,
                Invocation.method(#call, [tarefa]),
              ),
            ),
          )
          as _i5.Future<_i3.Either<_i6.Failure, Null>>);
}
