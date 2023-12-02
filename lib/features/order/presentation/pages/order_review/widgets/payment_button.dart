import 'dart:io';

import 'package:fiverr/core/config/app_assets.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay/pay.dart';

class PaymentButton extends StatelessWidget {
  PaymentButton({super.key});
  final googlePaymentConfiguration =
      PaymentConfiguration.fromAsset(AppAssets.googlePayConfig);
  final applePaymentConfiguration =
      PaymentConfiguration.fromAsset(AppAssets.googlePayConfig);
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? FutureBuilder(
            future: googlePaymentConfiguration,
            builder: (context, AsyncSnapshot<PaymentConfiguration> snapshot) {
              if (snapshot.hasData) {
                return GooglePayButton(
                  height: double.infinity,
                  paymentConfiguration: snapshot.data,
                  paymentItems: const [
                    PaymentItem(
                      amount: "100",
                      label: "Sub total",
                      status: PaymentItemStatus.final_price,
                      type: PaymentItemType.item,
                    ),
                    PaymentItem(
                      amount: "100",
                      label: "Service Fee",
                      status: PaymentItemStatus.final_price,
                      type: PaymentItemType.item,
                    ),
                    PaymentItem(
                      amount: "100",
                      label: "Total",
                      status: PaymentItemStatus.final_price,
                      type: PaymentItemType.total,
                    ),
                  ],
                  type: GooglePayButtonType.pay,
                  margin: const EdgeInsets.only(top: 15.0),
                  onError: (error) {
                    if (error is PlatformException) {
                      DialogCustom.showSnackBar(context,
                          message: error.message.toString());
                    } else {
                      DialogCustom.showSnackBar(context,
                          message: error.toString());
                    }
                  },
                  onPaymentResult: (data) {},
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                );
              }
            },
          )
        : FutureBuilder(
            future: applePaymentConfiguration,
            builder: (context, AsyncSnapshot<PaymentConfiguration> snapshot) {
              if (snapshot.hasData) {
                return ApplePayButton(
                  height: double.infinity,
                  paymentConfiguration: snapshot.data,
                  paymentItems: const [
                    PaymentItem(
                      amount: "100",
                      label: "Sub total",
                      status: PaymentItemStatus.final_price,
                      type: PaymentItemType.item,
                    ),
                    PaymentItem(
                      amount: "100",
                      label: "Service Fee",
                      status: PaymentItemStatus.final_price,
                      type: PaymentItemType.item,
                    ),
                    PaymentItem(
                      amount: "100",
                      label: "Total",
                      status: PaymentItemStatus.final_price,
                      type: PaymentItemType.total,
                    ),
                  ],
                  type: ApplePayButtonType.buy,
                  margin: const EdgeInsets.only(top: 15.0),
                  onError: (error) {
                    if (error is PlatformException) {
                      DialogCustom.showSnackBar(context,
                          message: error.message.toString());
                    } else {
                      DialogCustom.showSnackBar(context,
                          message: error.toString());
                    }
                  },
                  onPaymentResult: (data) {},
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                );
              }
            },
          );
  }
}
