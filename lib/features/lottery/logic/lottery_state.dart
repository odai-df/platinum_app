abstract class LotteryState {
  const LotteryState();
}

class LotteryInitial extends LotteryState {
  const LotteryInitial();
}

class LotteryLoading extends LotteryState {
  const LotteryLoading();
}

class LotterySuccess extends LotteryState {
  const LotterySuccess();
}

class LotteryError extends LotteryState {
  final String message;

  const LotteryError(this.message);
}

class LotteryDetailsLoaded extends LotteryState {}