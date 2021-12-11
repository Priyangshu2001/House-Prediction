part of 'house_bloc.dart';

abstract class HouseEvent extends Equatable {
  const HouseEvent();
}
class HouseRequested extends HouseEvent{
  final Data data;

  @override
  // TODO: implement props
  List<Object?> get props => [data];

  const HouseRequested({
    required this.data,
  });
}