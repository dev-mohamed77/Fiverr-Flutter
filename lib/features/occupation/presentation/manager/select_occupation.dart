import 'package:fiverr/features/occupation/domain/entity/occupation_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectOccupationProvider = StateProvider<String?>((ref) => null);
final selectOccupationSpecializationProvider =
    StateProvider<String?>((ref) => null);
final selectOccupationFromProvider = StateProvider<String?>((ref) => null);
final selectOccupationToProvider = StateProvider<String?>((ref) => null);

final selectDeleteOccupationProvider =
    StateProvider<OccupationEntity?>((ref) => null);
