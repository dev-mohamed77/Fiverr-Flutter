// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/gig_details/data/data_source/gig_details_local_data_source.dart';
import 'package:fiverr/features/gig_details/data/data_source/gig_details_remote_data_source.dart';
import 'package:fiverr/features/gig_details/data/model/gig_local_model.dart';
import 'package:fiverr/features/gig_details/domain/repository/gig_details_repository.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';

class GigDetailsRepositoryImp implements IGigDetailsRepository {
  final GigDetailsRemoteDataSource remoteDataSource;
  final GigDetailsLocalDataSource localDataSource;
  GigDetailsRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<ApiResult<GigEntity>> getGigByID({
    required String id,
  }) async {
    try {
      final data = await remoteDataSource.getGigByID(id: id);

      final localGigs = localDataSource.getGigs().toSet().toList();

      if (!localGigs.contains(
        GigLocalModel(
          id: data.id,
          title: data.title,
          image: data.coverImage,
          price: data.price,
        ),
      )) {
        localDataSource.addGig(
            model: GigLocalModel(
          id: data.id,
          title: data.title,
          image: data.coverImage,
          price: data.price,
        ));
      }

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}
