import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagameto_credit_pix/repositories/payment_repository.dart';
import '../blocs/payment/payment_bloc.dart';
import '../blocs/payment/payment_event.dart';
import '../blocs/payment/payment_state.dart';
import '../models/payment_request.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _referenceIdController = TextEditingController();
  final _amountController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expMonthController = TextEditingController();
  final _expYearController = TextEditingController();
  final _securityCodeController = TextEditingController();
  final _cardHolderNameController = TextEditingController();
  String _selectedPaymentMethod = 'CREDIT_CARD';

  void _processPayment(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final paymentRequest = PaymentRequest(
        referenceId: _referenceIdController.text,
        amount: int.parse(_amountController.text),
        paymentMethod: _selectedPaymentMethod,
        cardNumber: _selectedPaymentMethod == 'CREDIT_CARD' ? _cardNumberController.text : null,
        expMonth: _selectedPaymentMethod == 'CREDIT_CARD' ? _expMonthController.text : null,
        expYear: _selectedPaymentMethod == 'CREDIT_CARD' ? _expYearController.text : null,
        securityCode: _selectedPaymentMethod == 'CREDIT_CARD' ? _securityCodeController.text : null,
        cardHolderName: _selectedPaymentMethod == 'CREDIT_CARD' ? _cardHolderNameController.text : null,
      );

      context.read<PaymentBloc>().add(ProcessPaymentEvent(paymentRequest));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento'),
      ),
      body: BlocProvider(
        create: (context) => PaymentBloc(PaymentRepository()),
        child: BlocListener<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Pagamento realizado com sucesso')),
              );
            } else if (state is PaymentFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erro ao processar pagamento: ${state.error}')),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _referenceIdController,
                    decoration: InputDecoration(labelText: 'ID de Referência'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o ID de referência';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(labelText: 'Valor'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o valor';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedPaymentMethod,
                    decoration: InputDecoration(labelText: 'Método de Pagamento'),
                    items: [
                      DropdownMenuItem(value: 'CREDIT_CARD', child: Text('Cartão de Crédito')),
                      DropdownMenuItem(value: 'PIX', child: Text('PIX')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, selecione um método de pagamento';
                      }
                      return null;
                    },
                  ),
                  if (_selectedPaymentMethod == 'CREDIT_CARD') ...[
                    TextFormField(
                      controller: _cardNumberController,
                      decoration: InputDecoration(labelText: 'Número do Cartão'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o número do cartão';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _expMonthController,
                      decoration: InputDecoration(labelText: 'Mês de Expiração'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o mês de expiração';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _expYearController,
                      decoration: InputDecoration(labelText: 'Ano de Expiração'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o ano de expiração';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _securityCodeController,
                      decoration: InputDecoration(labelText: 'Código de Segurança'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o código de segurança';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _cardHolderNameController,
                      decoration: InputDecoration(labelText: 'Nome no Cartão'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome no cartão';
                        }
                        return null;
                      },
                    ),
                  ],
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _processPayment(context),
                    child: Text('Pagar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
