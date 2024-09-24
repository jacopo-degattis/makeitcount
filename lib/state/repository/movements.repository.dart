import 'package:makeitcount/db.dart';
import 'package:makeitcount/state/models/movement.model.dart';
import 'package:makeitcount/objectbox.g.dart';

abstract class MovementsRepositoryDefinition {
  void addMovement(
    String name,
    String category,
    double price,
    int imageCodePoint,
    int month,
    bool income,
  );
  List<MovementModel> getMovementsByMonth(int month, {int? limit});
  Map<String, dynamic> getMovementsPercentages(int month);
  // TODO: maybe add "add, remove, edit" movement/s
}

class MovementsRepository extends MovementsRepositoryDefinition {
  final ObjectBoxDatabase _objectBoxDatabase;

  MovementsRepository(
    this._objectBoxDatabase,
  );

  @override
  void addMovement(
    String name,
    String category,
    double price,
    int imageCodePoint,
    int month,
    bool income,
  ) {
    final box = _objectBoxDatabase.store.box<MovementModel>();
    box.put(
        MovementModel(0, name, price, category, imageCodePoint, month, income));
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

  @override
  Map<String, dynamic> getMovementsPercentages(int month) {
    final totalMovements = getMovementsByMonth(month);
    final incomesMovements = totalMovements.where((x) => x.income);
    final outcomesMovements = totalMovements.where((x) => !x.income);

    num incomesPercentage = num.parse(
        (incomesMovements.length * 100 / totalMovements.length)
            .toStringAsFixed(1));
    num outcomesPercentage = num.parse(
        (outcomesMovements.length * 100 / totalMovements.length)
            .toStringAsFixed(1));

    // TODO: improve this type to make it type-safe
    Map<String, dynamic> percentages = {
      "incomes": {
        "percentage": !incomesPercentage.isNaN ? incomesPercentage : 0,
        "amount": num.parse((incomesMovements
            .map((x) => x.price)
            .fold(0.0, (prev, price) => prev + price)).toStringAsFixed(1)),
      },
      "outcomes": {
        "percentage": !outcomesPercentage.isNaN ? outcomesPercentage : 0,
        "amount": num.parse((outcomesMovements
            .map((x) => x.price)
            .fold(0.0, (prev, price) => prev + price)).toStringAsFixed(1))
      },
      "total": num.parse((totalMovements
          .map((x) => {"price": x.price, "income": x.income})
          .fold(0.0, (prev, price) {
        if (price["income"] as bool) {
          return prev + (price["price"] as num);
        } else {
          return prev - (price["price"] as num);
        }
      })).toStringAsFixed(1))
    };

    return percentages;
  }
}
