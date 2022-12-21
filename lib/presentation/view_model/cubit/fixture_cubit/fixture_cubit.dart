import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fixure_state.dart';

class FixureCubit extends Cubit<FixureState> {
  FixureCubit() : super(FixureInitial());
}
