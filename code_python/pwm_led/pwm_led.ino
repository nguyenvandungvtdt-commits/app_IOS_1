#include <WiFi.h>
#include <WebServer.h>

// Thông tin Wi-Fi
const char* ssid     = "ELEC";
const char* password = "66668888";

const int LED_PIN = 12; // Chân LED D12

// CẤU HÌNH PWM PHẦN CỨNG (LEDC)
const int PWM_FREQ       = 5000; // Tần số 5kHz (Cao gấp 10 lần tần số mắt nhìn thấy -> chống nhấp nháy)
const int PWM_CHANNEL    = 0;    // Dùng Kênh 0
const int PWM_RESOLUTION = 8;    // Độ phân giải 8-bit (0 - 255)

int brightness = 0; // Độ sáng (0 - 255)

WebServer server(80);

const char HTML_PAGE[] PROGMEM = R"rawliteral(
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Điều Khiển LED D12 Chống Nhấp Nháy</title>
  <style>
    body { font-family: Arial, sans-serif; background: #121826; color: white; text-align: center; padding: 20px; }
    .card { background: #1e293b; max-width: 350px; margin: 0 auto; padding: 20px; border-radius: 16px; box-shadow: 0 4px 15px rgba(0,0,0,0.5); }
    .val { font-size: 48px; font-weight: bold; color: #38bdf8; margin: 15px 0; }
    .btn-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-top: 15px; }
    button { padding: 15px; font-size: 15px; font-weight: bold; border: none; border-radius: 10px; color: white; cursor: pointer; }
    button:active { transform: scale(0.95); }
    .btn-on { background: #10b981; }
    .btn-off { background: #ef4444; }
    .btn-up { background: #3b82f6; }
    .btn-down { background: #f59e0b; }
    input[type=range] { width: 100%; margin: 15px 0; }
  </style>
</head>
<body>
  <div class="card">
    <h2>LED CHÂN D12 (ỔN ĐỊNH)</h2>
    <div class="val" id="brightVal">0%</div>

    <input type="range" id="slider" min="0" max="255" value="0" onchange="setBright(this.value)">

    <div class="btn-grid">
      <button class="btn-on" onclick="sendCmd('on')">ON (100%)</button>
      <button class="btn-off" onclick="sendCmd('off')">OFF (0%)</button>
      <button class="btn-up" onclick="sendCmd('up')">+ TĂNG</button>
      <button class="btn-down" onclick="sendCmd('down')">- GIẢM</button>
    </div>
  </div>

  <script>
    function updateUI(val) {
      document.getElementById('brightVal').innerText = Math.round((val / 255) * 100) + '%';
      document.getElementById('slider').value = val;
    }

    function sendCmd(cmd) {
      fetch('/action?cmd=' + cmd)
        .then(res => res.text())
        .then(val => updateUI(parseInt(val)));
    }

    function setBright(val) {
      fetch('/set?val=' + val)
        .then(res => res.text())
        .then(val => updateUI(parseInt(val)));
    }
  </script>
</body>
</html>
)rawliteral";

// Hàm ghi độ sáng bằng PWM phần cứng
void setLED(int val) {
  brightness = constrain(val, 0, 255);
  
  #if defined(ESP_ARDUINO_VERSION_MAJOR) && ESP_ARDUINO_VERSION_MAJOR >= 3
    // Cho ESP32 Core v3.x
    ledcWrite(LED_PIN, brightness);
  #else
    // Cho ESP32 Core v2.x
    ledcWrite(PWM_CHANNEL, brightness);
  #endif
}

void handleRoot() {
  server.send(200, "text/html", HTML_PAGE);
}

void handleAction() {
  if (server.hasArg("cmd")) {
    String cmd = server.arg("cmd");
    if (cmd == "on") setLED(255);
    else if (cmd == "off") setLED(0);
    else if (cmd == "up") setLED(brightness + 25);
    else if (cmd == "down") setLED(brightness - 25);
  }
  server.send(200, "text/plain", String(brightness));
}

void handleSet() {
  if (server.hasArg("val")) {
    setLED(server.arg("val").toInt());
  }
  server.send(200, "text/plain", String(brightness));
}

void setup() {
  Serial.begin(115200);

  // KÍCH HOẠT PWM PHẦN CỨNG
  #if defined(ESP_ARDUINO_VERSION_MAJOR) && ESP_ARDUINO_VERSION_MAJOR >= 3
    ledcAttach(LED_PIN, PWM_FREQ, PWM_RESOLUTION);
  #else
    ledcSetup(PWM_CHANNEL, PWM_FREQ, PWM_RESOLUTION);
    ledcAttachPin(LED_PIN, PWM_CHANNEL);
  #endif

  setLED(0); // Mặc định tắt LED

  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("\nWiFi Connected!");
  Serial.print("IP: http://");
  Serial.println(WiFi.localIP());

  server.on("/", handleRoot);
  server.on("/action", handleAction);
  server.on("/set", handleSet);

  server.begin();
}

void loop() {
  server.handleClient();
}