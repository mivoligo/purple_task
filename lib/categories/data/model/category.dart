import 'package:equatable/equatable.dart';

class Category extends Equatable {
  Category({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });

  final int id;
  final String name;
  final int color;
  final int icon;

  @override
  List<Object?> get props => throw UnimplementedError();
}
