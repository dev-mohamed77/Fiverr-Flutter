import 'package:fiverr/core/manager/router/global_navigator_key.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/providers/token/token_provider.dart';
import 'package:fiverr/features/auth/presentation/pages/auth/auth_screen.dart';
import 'package:fiverr/features/auth/presentation/pages/forget_password/forget_password_screen.dart';
import 'package:fiverr/features/auth/presentation/pages/reset_password/reset_password_screen.dart';
import 'package:fiverr/features/auth/presentation/pages/signin/signin_screen.dart';
import 'package:fiverr/features/auth/presentation/pages/signup/signup_screen.dart';
import 'package:fiverr/features/auth/presentation/pages/verify_reset_code/verify_reset_code_screen.dart';
import 'package:fiverr/features/explore/presentation/pages/explore_screen.dart';
import 'package:fiverr/features/gig_details/presentation/pages/gig_details_screen.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/features/gigs/presentation/pages/create_gig/create_gig_screen.dart';
import 'package:fiverr/features/gigs/presentation/pages/gigs_screen/country_screen.dart';
import 'package:fiverr/features/gigs/presentation/pages/gigs_screen/filter_screen.dart';
import 'package:fiverr/features/gigs/presentation/pages/gigs_screen/gigs_screen.dart';
import 'package:fiverr/features/gigs/presentation/pages/gigs_screen/language_screen.dart';
import 'package:fiverr/features/gigs/presentation/pages/update_gig_screen/update_gig_screen.dart';
import 'package:fiverr/features/home/presentation/pages/home_screen.dart';
import 'package:fiverr/features/chat/presentation/pages/chat_screen.dart';
import 'package:fiverr/features/inbox/presentation/pages/inbox_screen.dart';
import 'package:fiverr/features/language/presentation/pages/language_screen.dart';
import 'package:fiverr/features/my_list/presentation/pages/mylist_screen.dart';
import 'package:fiverr/features/nav_bar/presentation/pages/nav_bar_screen.dart';
import 'package:fiverr/features/occupation/presentation/pages/occupation_screen.dart';
import 'package:fiverr/features/order/presentation/pages/order_confirm/order_confirm_screen.dart';
import 'package:fiverr/features/order/presentation/pages/order_review/order_review_screen.dart';
import 'package:fiverr/features/order/presentation/pages/orders/orders_screen.dart';
import 'package:fiverr/features/profile/presentation/pages/account/account_screen.dart';
import 'package:fiverr/features/profile/presentation/pages/change_password/change_password_screen.dart';
import 'package:fiverr/features/profile/presentation/pages/edit_account/edit_account.dart';
import 'package:fiverr/features/profile/presentation/pages/profile/profile_screen.dart';
import 'package:fiverr/features/reviews/presentation/pages/create_review/create_review_screen.dart';
import 'package:fiverr/features/reviews/presentation/pages/reviews_screen/reviews_screen.dart';
import 'package:fiverr/features/seller/presentation/pages/create_seller/personal_info/personal_info_screen.dart';
import 'package:fiverr/features/seller/presentation/pages/create_seller/welcome_create_seller/welcome_seller_screen.dart';
import 'package:fiverr/features/seller/presentation/pages/seller_account/seller_account_screen.dart';
import 'package:fiverr/features/skill/presentation/pages/skill_screen.dart';
import 'package:fiverr/features/subcategory/presentation/pages/subcategory_screen.dart';
import 'package:fiverr/features/welcome/presentation/pages/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RouterManager {
  RouterManager._();

  static dynamic router(GlobalKey<NavigatorState> shellNavigator, Ref ref) {
    final token = ref.watch(tokenProvider);
    return [
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.welcomeScreen,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const WelcomeScreen(),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.auth,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const AuthScreen(),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.signUp,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const SignUpScreen(),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.signIn,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const SignInScreen(),
          );
        },
      ),
      GoRoute(
        path: Routes.forgetPassword,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const ForgetPasswordScreen(),
          );
        },
      ),
      GoRoute(
        path: Routes.verifyResetCode,
        name: Routes.verifyResetCode,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const VerifyResetCodeScreen(),
          );
        },
      ),
      GoRoute(
        path: Routes.resetPassword,
        name: Routes.resetPassword,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const ResetPasswordScreen(),
          );
        },
      ),

      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.chat,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return MaterialPage(
            key: state.pageKey,
            child: ChatScreen(
              sellerId: data["sellerId"],
              sender: data["sender"],
            ),
          );
        },
        redirect: (context, state) {
          if (token == null) {
            return Routes.signIn;
          }

          return null;
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.createReview,
        name: Routes.createReview,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: CreateReviewScreen(gigID: state.extra as String),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.gigs,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const GigsScreen(),
          );
        },
      ),

      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.gigDetails,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const GigDetailsScreen(),
          );
        },
        routes: [
          GoRoute(
            parentNavigatorKey: rootNavigator,
            path: Routes.reviews,
            name: Routes.reviews,
            pageBuilder: (context, state) {
              final count = state.extra as Map<String, String>;
              return MaterialPage(
                key: state.pageKey,
                child: ReviewsScreen(
                  reviewsCount: count["length"] as String,
                ),
              );
            },
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.myList,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const NyListScreen(),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.account,
        name: Routes.account,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const AccountScreen(),
          );
        },
        routes: [
          GoRoute(
            parentNavigatorKey: rootNavigator,
            path: Routes.editAccount,
            name: Routes.editAccount,
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                child: const EditAccountScreen(),
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: rootNavigator,
            path: Routes.changePassword,
            name: Routes.changePassword,
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                child: const ChangePasswordScreen(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.filter,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const FilterScreen(),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.country,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const CountryScreen(),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.language,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const LanguageScreen(),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.sellerAccount,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: SellerAccountScreen(
              isSellerLoggedUser:
                  state.extra != null ? state.extra as bool : null,
            ),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.orderReview,
        name: Routes.orderReview,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return MaterialPage(
            key: state.pageKey,
            child: OrderReviewScreen(
              gig: data["gig"] as GigEntity,
              sellerId: data["sellerId"] as String,
            ),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.orderConfirm,
        name: Routes.orderConfirm,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            key: state.pageKey,
            child: const OrderConfirmScreen(),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.welcomeCreateSeller,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const WelcomeCreateSellerScreen(),
          );
        },
        routes: [
          GoRoute(
            parentNavigatorKey: rootNavigator,
            path: Routes.personalInfo,
            name: Routes.personalInfo,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: const PersonalInfoScreen(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.sellerLanguage,
        name: Routes.sellerLanguage,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return NoTransitionPage(
            key: state.pageKey,
            child: SellerLanguageScreen(
              sellerId: data["sellerId"],
              isSellerPage: data["isSellerPage"],
            ),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.sellerOccupation,
        name: Routes.sellerOccupation,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return NoTransitionPage(
            key: state.pageKey,
            child: OccupationScreen(
              sellerId: data["sellerId"],
              isSellerPage: data["isSellerPage"],
            ),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.sellerSkill,
        name: Routes.sellerSkill,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return NoTransitionPage(
            key: state.pageKey,
            child: SkillScreen(
              sellerId: data["sellerId"],
              isSellerPage: data["isSellerPage"],
            ),
          );
        },
      ),

      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.createGig,
        name: Routes.createGig,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            key: state.pageKey,
            child: const CreateGigScreen(),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigator,
        path: Routes.updateGig,
        name: Routes.updateGig,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            key: state.pageKey,
            child: UpdateGigScreen(
              gig: state.extra as GigEntity,
            ),
          );
        },
      ),

      // bottom navigation bar
      ShellRoute(
        navigatorKey: shellNavigator,
        builder: (context, state, child) => NavBarScreen(
          key: state.pageKey,
          child: child,
        ),
        routes: [
          GoRoute(
            path: Routes.home,
            parentNavigatorKey: shellNavigator,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: HomeScreen(
                  key: state.pageKey,
                ),
              );
            },
          ),
          GoRoute(
            path: Routes.inbox,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: InboxScreen(
                  key: state.pageKey,
                ),
              );
            },
            redirect: (context, state) {
              if (token == null) {
                return Routes.signIn;
              }

              return null;
            },
          ),
          GoRoute(
            path: Routes.order,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: OrdersScreen(
                  key: state.pageKey,
                ),
              );
            },
            redirect: (context, state) {
              if (token == null) {
                return Routes.signIn;
              }

              return null;
            },
          ),
          GoRoute(
            path: Routes.explore,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: ExploreScreen(
                  key: state.pageKey,
                ),
              );
            },
            routes: [
              GoRoute(
                path: Routes.subCategory,
                name: Routes.subCategory,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: SubCategoryScreen(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: Routes.profile,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: ProfileScreen(
                  key: state.pageKey,
                ),
              );
            },
          ),
        ],
      ),
    ];
  }
}
