import 'package:makeitcount/db.dart';
import 'package:makeitcount/state/models/movement.model.dart';
import 'package:makeitcount/objectbox.g.dart';

abstract class MovementsRepositoryDefinition {
  void addMovement(String name, String category, double price);
  List<MovementModel> getMovementsByMonth(int month, {int? limit});
  // TODO: maybe add "add, remove, edit" movement/s
}

class MovementsRepository extends MovementsRepositoryDefinition {
  final ObjectBoxDatabase _objectBoxDatabase;

  MovementsRepository(
    this._objectBoxDatabase,
  );

  @override
  void addMovement(String name, String category, double price) {
    print("Inserting new movement");
    final box = _objectBoxDatabase.store.box<MovementModel>();
    box.put(MovementModel(0, name, 45.99, category, "IMG", 9, 1));
    print("Done inserting movement");
  }

  @override
  List<MovementModel> getMovementsByMonth(int month, {int? limit}) {
    final box = _objectBoxDatabase.store.box<MovementModel>();
    final Query<MovementModel> query = (box
            .query(MovementModel_.month.equals(month))
            .order(MovementModel_.id, flags: Order.descending))
        .build();

    if (limit != null) {
      query.limit = limit;
    }

    return query.find();
  }
}
