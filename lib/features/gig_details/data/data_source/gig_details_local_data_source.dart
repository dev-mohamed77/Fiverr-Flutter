import 'package:fiverr/core/service/local_service/local_key.dart';
import 'package:fiverr/features/gig_details/data/model/gig_local_model.dart';
import 'package:hive/hive.dart';

abstract class GigDetailsLocalDataSource {
  Future<void> addGig({required GigLocalModel model});
  List<GigLocalModel> getGigs();
  // deleteGig();
}

class GigDetailsLocalDataSourceImp implements GigDetailsLocalDataSource {
  @override
  Future<void> addGig({required GigLocalModel model}) async {
    final box = Hive.box<GigLocalModel>(LocalHiveKey.gigs);

    box.add(model);
  }

  @override
  List<GigLocalModel> getGigs() {
    final box = Hive.box<GigLocalModel>(LocalHiveKey.gigs);
    return box.values.toList();
  }

  // @override
  // deleteGig() {
  //   final box = Hive.box<GigLocalModel>(LocalHiveKey.gigs);

  //   box.delete(key)
  // }
}
