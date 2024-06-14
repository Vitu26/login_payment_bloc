import 'package:equatable/equatable.dart';

abstract class DeliveryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadDeliveryLocation extends DeliveryEvent {}

class UpdateDeliveryLocation extends DeliveryEvent {
  final double latitude;
  final double longitude;

  UpdateDeliveryLocation(this.latitude, this.longitude);

  @override
  List<Object> get props => [latitude, longitude];
}

class SendClientLocation extends DeliveryEvent {
  final String clientId;
  final double latitude;
  final double longitude;

  SendClientLocation(this.clientId, this.latitude, this.longitude);

  @override
  List<Object> get props => [clientId, latitude, longitude];
}
