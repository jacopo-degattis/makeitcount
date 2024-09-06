import 'package:makeitcount/state/providers/database/objectbox.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:makeitcount/state/repository/movements.repository.dart';

part 'movements_repository.provider.g.dart';

@riverpod
MovementsRepository movementsRepository(MovementsRepositoryRef ref) {
  return MovementsRepository(ref.watch(databaseProvider));
}
