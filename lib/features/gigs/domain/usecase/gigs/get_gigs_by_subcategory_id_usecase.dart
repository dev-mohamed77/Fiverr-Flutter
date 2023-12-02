import 'package:fiverr/core/providers/country/country_provider.dart';
import 'package:fiverr/core/providers/language/language_providers.dart';
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/features/gigs/domain/repository/gigs_repository.dart';
import 'package:fiverr/features/gigs/presentation/manager/delivery_time_filter.dart';
import 'package:fiverr/features/gigs/presentation/manager/price_range_manager.dart';
import 'package:fiverr/features/subcategory/presentation/manager/select_subcategory_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetGigsBySubCategoryIdUseCase
    extends StateNotifier<AsyncValue<List<GigEntity>?>> {
  GetGigsBySubCategoryIdUseCase(this.repo, this.ref)
      : super(const AsyncValue.data(null));
  final GigsRepository repo;
  final Ref ref;

  final limit = 15;
  int page = 1;
  bool _noItemMore = false;

  bool get noItemMore => _noItemMore;

  Future<void> execute(
    String subCategoryID, {
    String? deliveryTime,
    String? maxPrice,
    String? minPrice,
    String? language,
    String? country,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.getGigsBySubCategoryId(
      subCategoryID,
      page: page.toString(),
      limit: limit.toString(),
      deliveryTime: deliveryTime,
      maxPrice: maxPrice,
      minPrice: minPrice,
      language: language,
      country: country,
    );

    result.when(success: (data) {
      _noItemMore = data.length < limit;
      state = AsyncValue.data(data);
    }, failure: (errorHandle) {
      state = AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      );
    });
  }

  loadedMoreData() {
    if (!_noItemMore) {
      page++;

      _fetchGigsBySubCategoryId();
    }
  }

  void _fetchGigsBySubCategoryId() async {
    final subCategory = ref.watch(selectSubCategoryProvider);
    final selectDeliveryTime = ref.watch(selectDeliveryTimeFilterProvider);
    final selectCountry = ref.watch(selectCountryProvider);
    final selectLanguage = ref.watch(selectLanguageProvider);
    final minPrice = ref.watch(minPriceProvider);
    final maxPrice = ref.watch(maxPriceProvider);
    final result = await repo.getGigsBySubCategoryId(
      subCategory?.id ?? "",
      page: page.toString(),
      limit: limit.toString(),
      country: selectCountry,
      language: selectLanguage,
      deliveryTime: selectDeliveryTime,
      maxPrice: maxPrice,
      minPrice: minPrice,
    );

    result.when(success: (data) {
      _noItemMore = data.length < limit;
      state = AsyncValue.data([...state.value ?? [], ...data]);
    }, failure: (errorHandle) {
      state = AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      );
    });
  }
}
