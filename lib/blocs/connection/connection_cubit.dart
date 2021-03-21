import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'connection_state.dart';

class InternetCubit extends Cubit<InternetState> {
  var connectionSubscription;

  InternetCubit() : super(InternetLoading()) {
    connectionSubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile)
        emitConnectedState();
      else if (result == ConnectivityResult.none) emitDisconnectedState();
    });
  }

  void emitConnectedState() => emit(InternetConnected());
  void emitDisconnectedState() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectionSubscription.cancel();
    return super.close();
  }
}
