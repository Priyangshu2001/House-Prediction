import 'dart:async';

import 'package:app/Model/Data.dart';
import 'package:app/Repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'house_event.dart';
part 'house_state.dart';

class HouseBloc extends Bloc<HouseEvent, HouseState> {

  HouseBloc() : super(HouseInitial()) {
    print("iHi");
    on<HouseRequested>((event, emit)async{
      // TODO: implement event handler

      Repository repos=Repository();
        emit( HouseLoading());
        try {
          print("13422bhrs");
          double d = await repos.getPredictedData(event.data);
          Predicted predicted=Predicted(predicted: d);
          emit( HouseSuccess(predicted: predicted));
        }
        catch (e) {
          emit( HouseFailure());
        }
      });
      }

  }