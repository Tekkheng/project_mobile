// class AccuracyModel {
//   const AccuracyModel(
//       {required this.kkn, required this.kMeans, required this.accuracyLstm});
//   final double kkn, kMeans, accuracyLstm;
// }

// Accuracy
// Presisi
// Recall
// F1Score
// MAE
// MSE
// RMSE

// jurnal ke google drive
class AccuracyModel {
  const AccuracyModel(
      {required this.type,
      this.accuracy,
      this.presisi,
      this.recall,
      this.f1Score,
      this.mae,
      this.mse,
      this.rmse});

  final String type;
  final double? presisi, recall, f1Score;
  final double? accuracy, mae, mse, rmse;
}
