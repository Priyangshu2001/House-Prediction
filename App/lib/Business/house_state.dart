part of 'house_bloc.dart';

abstract class HouseState extends Equatable {
  const HouseState();
  @override
  List<Object> get props => [];
}

class HouseInitial extends HouseState {}
class HouseLoading extends HouseState{}
class HouseSuccess extends HouseState{
  final Predicted predicted;

  const HouseSuccess({
    required this.predicted,
  });
  @override
  List<Object> get props => [predicted];
}
class HouseFailure extends HouseState{}
