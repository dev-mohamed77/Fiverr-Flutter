import 'package:hive/hive.dart';
part 'gig_local_model.g.dart';

@HiveType(typeId: 0)
class GigLocalModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final int price;

  GigLocalModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
  });
}
