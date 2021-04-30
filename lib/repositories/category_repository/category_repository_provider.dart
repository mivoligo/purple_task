import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories.dart';

final categoryRepositoryProvider = Provider<BaseCategoryRepository>((ref) {
  return CategoryRepository();
});
