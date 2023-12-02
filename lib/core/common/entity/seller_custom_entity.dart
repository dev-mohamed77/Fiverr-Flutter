// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class SellerCustomEntity extends Equatable {
  final String id;
  final String fullName;

  const SellerCustomEntity({
    required this.id,
    required this.fullName,
  });

  @override
  List<Object> get props => [id, fullName];
}
