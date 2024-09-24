import 'package:objectbox/objectbox.dart';

@Entity()
class MovementModel {
  @Id()
  int id = 0;

  String title;
  String category;
  double price;
  int imageCodePoint;
  int month;
  bool income; // If true is income otherwise outcome

  MovementModel(this.id, this.title, this.price, this.category,
      this.imageCodePoint, this.month, this.income);
}
