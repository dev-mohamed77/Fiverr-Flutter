// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:fiverr/features/skill/data/model/skill_model.dart';

abstract class SkillRemoteDataSource {
  Future<SkillModel> createSkill({
    required String sellerId,
    required String skill,
    required String level,
  });

  Future<List<SkillModel>> getSkillsBySellerId(
    String sellerId,
  );
  Future<SkillModel> updateSkill(
    String id, {
    String? skill,
    String? level,
  });
  Future<String> deleteSkill(String id);
}

class SkillRemoteDataSourceImp implements SkillRemoteDataSource {
  final NetWorkService netWorkService;
  SkillRemoteDataSourceImp({
    required this.netWorkService,
  });

  @override
  Future<SkillModel> createSkill({
    required String skill,
    required String level,
    required String sellerId,
  }) async {
    final response = await netWorkService.postData(
      "skills",
      data: {
        "seller": sellerId,
        "skill": skill,
        "level": level,
      },
    );

    final data = response.data["result"];

    return SkillModel.fromMap(data);
  }

  @override
  Future<List<SkillModel>> getSkillsBySellerId(String sellerId) async {
    final response = await netWorkService.getData(
      "$sellerId/skills-seller",
    );

    final Iterable data = response.data["result"];

    final skills = data.map((s) => SkillModel.fromMap(s)).toList();

    return skills;
  }

  @override
  Future<SkillModel> updateSkill(
    String id, {
    String? skill,
    String? level,
  }) async {
    final response = await netWorkService.updateData(
      "skills/$id",
      data: {
        "skill": skill,
        "level": level,
      },
    );

    final data = response.data["result"];

    return SkillModel.fromMap(data);
  }

  @override
  Future<String> deleteSkill(String id) async {
    final response = await netWorkService.deleteData(
      "skills/$id",
    );

    final data = response.data["result"];

    return data;
  }
}
