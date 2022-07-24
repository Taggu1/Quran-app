import 'package:dartz/dartz.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/domain/repositories/werd_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../settings/domain/entities/settings.dart';
import '../entities/werd.dart';

class FetchWerdUseCase {
  final WerdRepository repository;

  FetchWerdUseCase({required this.repository});

  Future<Either<Failure, Werd>> call() {
    return repository.fetchWerd();
  }
}
