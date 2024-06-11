class PaymentRequest {
  final String referenceId;
  final int amount;
  final String paymentMethod; // "CREDIT_CARD" or "PIX"
  final String? cardNumber;
  final String? expMonth;
  final String? expYear;
  final String? securityCode;
  final String? cardHolderName;

  PaymentRequest({
    required this.referenceId,
    required this.amount,
    required this.paymentMethod,
    this.cardNumber,
    this.expMonth,
    this.expYear,
    this.securityCode,
    this.cardHolderName,
  });

  Map<String, dynamic> toJson() {
    return {
      'reference_id': referenceId,
      'amount': {
        'value': amount,
        'currency': 'BRL'
      },
      'payment_method': paymentMethod == 'CREDIT_CARD'
          ? {
              'type': 'CREDIT_CARD',
              'installments': 1,
              'capture': true,
              'card': {
                'number': cardNumber,
                'exp_month': expMonth,
                'exp_year': expYear,
                'security_code': securityCode,
                'holder': {
                  'name': cardHolderName,
                },
              },
            }
          : {
              'type': 'PIX',
            },
    };
  }
}
