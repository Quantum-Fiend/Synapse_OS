import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:synapseos_flutter/core/network/sync_service_client.dart';

// Events
abstract class PresenceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PresenceUpdated extends PresenceEvent {
  final List<String> onlineUsers;
  PresenceUpdated(this.onlineUsers);
}

// States
class PresenceState extends Equatable {
  final List<String> onlineUsers;
  const PresenceState({this.onlineUsers = const []});

  @override
  List<Object> get props => [onlineUsers];
}

// Bloc
class PresenceBloc extends Bloc<PresenceEvent, PresenceState> {
  late final SyncServiceClient _syncClient;

  PresenceBloc() : super(const PresenceState()) {
    _syncClient = SyncServiceClient(onEventReceived: (data) {
      if (data['eventType'] == 'presence') {
        // Handle presence updates from backend
      }
    });

    on<PresenceUpdated>((event, emit) {
      emit(PresenceState(onlineUsers: event.onlineUsers));
    });
  }

  void connect(String userId) {
    _syncClient.connect(userId);
  }
}
