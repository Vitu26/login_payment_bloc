import 'package:equatable/equatable.dart';

abstract class DeliveryState extends Equatable {
  @override
  List<Object> get props => [];
}

class DeliveryInitial extends DeliveryState {}

class DeliveryLoading extends DeliveryState {}

class DeliveryLoaded extends DeliveryState {
  final double latitude;
  final double longitude;

  DeliveryLoaded(this.latitude, this.longitude);

  @override
  List<Object> get props => [latitude, longitude];
}

class DeliveryError extends DeliveryState {
  final String message;

  DeliveryError(this.message);

  @override
  List<Object> get props => [message];
}
