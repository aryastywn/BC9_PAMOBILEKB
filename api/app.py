from flask import Flask, request, jsonify
from flask_cors import CORS  # Mengimpor flask_cors untuk mengatasi CORS
import joblib
import numpy as np

# Inisialisasi aplikasi Flask
app = Flask(__name__)
CORS(app)  # Mengaktifkan CORS untuk semua endpoint

# Memuat model yang sudah disimpan menggunakan joblib
model = joblib.load('gbm_model_diabetes.pkl')

@app.route('/')
def home():
    return "Diabetes Prediction Model API"

# Endpoint untuk prediksi
@app.route('/predict', methods=['POST'])
def predict():
    # Ambil data dari request POST dalam format JSON
    data = request.get_json()

    # Cek jumlah fitur yang diterima
    features = data['features']
    if len(features) != 10:
        return jsonify({'error': 'Expected 10 features, got {}'.format(len(features))}), 400

    # Data input untuk prediksi harus berupa array atau list yang sesuai dengan fitur model
    features_array = np.array([features])

    # Prediksi menggunakan model
    prediction = model.predict(features_array)

    # Mengirim hasil prediksi ke client dalam format JSON
    return jsonify({'prediction': int(prediction[0])})

# Menjalankan aplikasi Flask
if __name__ == '__main__':
    app.run(debug=True)
