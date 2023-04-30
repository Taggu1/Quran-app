import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String userId;

  AppUser({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}
