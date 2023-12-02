import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:fiverr/features/language/data/model/language_model.dart';

abstract class LanguageRemoteDataSource {
  Future<LanguageModel> createLanguage({
    required String language,
    required String level,
    required String sellerId,
  });

  Future<List<LanguageModel>> getLanguagesBySellerId(
    String sellerId,
  );
  Future<LanguageModel> updateLanguage(
    String id, {
    String? language,
    String? level,
  });
  Future<String> deleteLanguage(String id);
}

class LanguageRemoteDataSourceImp implements LanguageRemoteDataSource {
  final NetWorkService netWorkService;
  LanguageRemoteDataSourceImp({
    required this.netWorkService,
  });

  @override
  Future<LanguageModel> createLanguage({
    required String language,
    required String level,
    required String sellerId,
  }) async {
    final response = await netWorkService.postData(
      "languages",
      data: {
        "language": language,
        "level": level,
        "seller": sellerId,
      },
    );

    final data = response.data["result"];

    return LanguageModel.fromMap(data);
  }

  @override
  Future<List<LanguageModel>> getLanguagesBySellerId(String sellerId) async {
    final response = await netWorkService.getData("$sellerId/languages-seller");

    final Iterable data = response.data["result"];

    final languages = data.map((lang) => LanguageModel.fromMap(lang)).toList();

    return languages;
  }

  @override
  Future<LanguageModel> updateLanguage(
    String id, {
    String? language,
    String? level,
  }) async {
    final response = await netWorkService.updateData(
      "languages/$id",
      data: {
        "language": language,
        "level": level,
      },
    );

    final data = response.data["result"];

    return LanguageModel.fromMap(data);
  }

  @override
  Future<String> deleteLanguage(String id) async {
    final response = await netWorkService.deleteData("languages/$id");

    final data = response.data["result"];

    return data;
  }
}
