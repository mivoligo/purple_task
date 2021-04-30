import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories.dart';

final categoryRepositoryProvider = Provider((ref) => CategoryRepository());
