class FontSizeManager {
  // Shared state across ALL pages
  static double currentTitleSize = 20.0;
  static double currentContentSize = 17.0;
  static bool isProcessing = false;
  
  static void cycleToNextSize() {
    const tolerance = 0.01;
    
    if ((currentTitleSize - 20.0).abs() < tolerance) {
      currentTitleSize = 24.0;
      currentContentSize = 20.4;
    } else if ((currentTitleSize - 24.0).abs() < tolerance) {
      currentTitleSize = 28.0;
      currentContentSize = 23.8;
    } else if ((currentTitleSize - 28.0).abs() < tolerance) {
      currentTitleSize = 32.0;
      currentContentSize = 27.2;
    } else {
      currentTitleSize = 20.0;
      currentContentSize = 17.0;
    }
  }
}