import 'package:dartz/dartz.dart';
import 'package:quran_app_clean_architecture/src/core/error/failures.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/domain/entities/werd.dart';

abstract class WerdRepository {
  Future<Either<Failure, Werd>> fetchWerd();
}
