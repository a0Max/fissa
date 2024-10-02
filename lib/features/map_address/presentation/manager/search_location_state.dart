part of 'search_location_cubit.dart';

enum StateOfTextField { loading, empty, initial, error, done }

@immutable
final class SearchLocationInitial extends Equatable {
  final StateOfTextField stateOfTextField;
  final List<PredictionsModel>? locations;
  final String? message;

  SearchLocationInitial(
      {required this.stateOfTextField, this.locations, this.message});

  @override
  List<Object?> get props => [locations, stateOfTextField, message];
}
