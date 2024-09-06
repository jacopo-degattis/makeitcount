import 'package:objectbox/objectbox.dart';

@Entity()
class MovementModel {
  @Id()
  int id = 0;

  String title;
  String category;
  double price;
  String image;
  int month;
  int type; // TODO: improve this to an enum or any other way

  MovementModel(this.id, this.title, this.price, this.category, this.image,
      this.month, this.type);
}
