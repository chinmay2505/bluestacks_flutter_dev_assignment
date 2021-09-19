import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ThemeState extends Equatable {
  final Map<Object, Object> themeData;

  const ThemeState({
    required this.themeData,
  }) : super();

  @override
  List<Object> get props => [themeData];
}
