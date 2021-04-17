part of 'new_category_cubit.dart';

enum NewCategoryStatus { initial, name, color, icon, tasks }

class NewCategoryState extends Equatable {
  const NewCategoryState({
    required this.name,
    required this.color,
    required this.icon,
    required this.status,
  });

  factory NewCategoryState.initial() {
    return NewCategoryState(
      name: '',
      color: 1,
      icon: AntIcons.folder.codePoint,
      status: NewCategoryStatus.initial,
    );
  }

  final String name;
  final int color;
  final int icon;
  final NewCategoryStatus status;

  @override
  List<Object> get props => [name, color, icon, status];

  NewCategoryState copyWith({
    String? name,
    int? color,
    int? icon,
    NewCategoryStatus? status,
  }) {
    return NewCategoryState(
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      status: status ?? this.status,
    );
  }
}
