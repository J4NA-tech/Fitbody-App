
import 'package:fitbodys/workoutlog.dart';

/// WorkoutLogManager sınıfı, Singleton olarak tasarlanmıştır.
/// Uygulama boyunca yalnızca bir örneği kullanılır ve bu sayede merkezi bir egzersiz geçmişi yönetimi yapılabilir.
class WorkoutLogManager {
  // Bu satır, sınıfın kendisinden tek bir örnek oluşturur (singleton pattern).
  static final WorkoutLogManager _instance = WorkoutLogManager._internal();

  // Kullanıcı sınıfı doğrudan oluşturmak isterse, ona bu örneği verir.
  factory WorkoutLogManager() => _instance;

  // Private constructor. Dışarıdan doğrudan sınıf oluşturulamaz.
  WorkoutLogManager._internal();

  // Egzersiz geçmişini tutan liste. Uygulama çalıştığı sürece bu veriler RAM'de tutulur.
  final List<WorkoutLog> logs = [];

  /// Yeni bir egzersiz kaydını listeye ekler.
  void addLog(WorkoutLog log) {
    logs.add(log);
  }

  /// Kaydedilen tüm egzersiz geçmişini döner.
  /// .reversed ile en son yapılan egzersiz en üstte gösterilir.
  List<WorkoutLog> getLogs() {
    return logs.reversed.toList(); // en yeni log en başta olacak şekilde liste döner
  }
}
