// Classe ZoomSettings
// Gerencia o nível de zoom da interface
class ZoomSettings {
  double _zoomLevel = 1.0;

  // Define o nível de zoom da interface
  double setZoom(double zoomLevel) {
    _zoomLevel = zoomLevel;
    return _zoomLevel;
  }

  // Retorna o nível de zoom atual
  double getZoomLevel() {
    return _zoomLevel;
  }
}