import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/werd.dart';

abstract class WerdRepository {
  Future<Either<Failure, Werd>> fetchWerd();
}
