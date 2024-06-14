import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:pagameto_credit_pix/blocs/delivery/delivery_event.dart';
import 'package:pagameto_credit_pix/blocs/delivery/delivery_state.dart';


class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  DeliveryBloc() : super(DeliveryInitial()) {
    on<LoadDeliveryLocation>((event, emit) async {
      emit(DeliveryLoading());
      try {
        FirebaseFirestore.instance
            .collection('deliveries')
            .doc('deliveryId')
            .snapshots()
            .listen((snapshot) {
          if (snapshot.exists) {
            var data = snapshot.data()!;
            emit(DeliveryLoaded(data['latitude'], data['longitude']));
          }
        });
      } catch (e) {
        emit(DeliveryError(e.toString()));
      }
    });

    on<UpdateDeliveryLocation>((event, emit) {
      FirebaseFirestore.instance
          .collection('deliveries')
          .doc('deliveryId') // ID do entregador
          .update({
        'latitude': event.latitude,
        'longitude': event.longitude,
      });
    });

    on<SendClientLocation>((event, emit) async {
      try {
        final response = await http.post(
          Uri.parse('http://your_laravel_backend/api/client/location'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'client_id': event.clientId,
            'latitude': event.latitude,
            'longitude': event.longitude,
          }),
        );

        if (response.statusCode != 200) {
          emit(DeliveryError('Failed to send client location'));
        }
      } catch (e) {
        emit(DeliveryError(e.toString()));
      }
    });
  }
}
