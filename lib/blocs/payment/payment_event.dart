import 'package:equatable/equatable.dart';
import '../../models/payment_request.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class ProcessPaymentEvent extends PaymentEvent {
  final PaymentRequest paymentRequest;

  const ProcessPaymentEvent(this.paymentRequest);

  @override
  List<Object> get props => [paymentRequest];
}
