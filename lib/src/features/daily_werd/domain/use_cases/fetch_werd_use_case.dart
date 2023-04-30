import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../settings/domain/entities/settings.dart';
import '../entities/werd.dart';
import '../repositories/werd_repository.dart';

class FetchWerdUseCase {
  final WerdRepository repository;

  FetchWerdUseCase({required this.repository});

  Future<Either<Failure, Werd>> call() {
    return repository.fetchWerd();
  }
}
