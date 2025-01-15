import 'package:equatable/equatable.dart';

enum MigrationStatus {
  idle,
  pending,
  success,
  error,
}

class MigrationState extends Equatable {
  const MigrationState({
    required this.migrationStatus,
    this.errorMessage,
  });

  final MigrationStatus migrationStatus;
  final String? errorMessage;

  MigrationState copyWith({
    MigrationStatus? migrationStatus,
    String? errorMessage,
  }) {
    return MigrationState(
      migrationStatus: migrationStatus ?? this.migrationStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [migrationStatus, errorMessage];
}
