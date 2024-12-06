import 'package:flutter/material.dart';
import 'diabetes_prediction_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Ilustrasi
              Center(
                child: Image.asset(
                  'assets/diabetes.jpg',
                  height: 200,
                ),
              ),
              const SizedBox(height: 20),

              // Judul
              const Text(
                'Kenali Risiko Diabetes Anda!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Informasi Edukatif
              const Text(
                'Diabetes adalah penyakit serius yang dapat mempengaruhi kualitas hidup Anda. '
                'Dengan deteksi dini, Anda bisa mengelola dan mengurangi risikonya. Ayo cek risiko Anda sekarang!',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Informasi Model Prediksi
              const Text(
                'Aplikasi ini memakai model prediksi Gradient Boosting Machine (GBM), '
                'yang merupakan algoritma machine learning yang kuat. GBM bekerja dengan cara membangun beberapa model prediksi secara berurutan, '
                'di mana setiap model baru berusaha untuk memperbaiki kesalahan model sebelumnya. Hal ini memungkinkan GBM untuk memberikan prediksi yang lebih akurat '
                'pada data yang kompleks dan tidak linear.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Tombol Call to Action
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // Navigasi ke halaman InputForm
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DiabetesPredictionForm(),
                      ),
                    );
                  },
                  child: const Text(
                    'Cek Risiko Diabetes',
                    style: TextStyle(fontSize: 18,color: Colors.white,),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Informasi Edukatif mengenai Istilah
              const Text(
                'Penjelasan Istilah Kesehatan:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),
              _buildInfoCard(
                title: 'Hypertension (Hipertensi)',
                description:
                    'Hipertensi adalah kondisi ketika tekanan darah lebih tinggi dari normal. '
                    'Ini meningkatkan risiko penyakit jantung dan stroke.',
              ),
              _buildInfoCard(
                title: 'Heart Disease (Penyakit Jantung)',
                description:
                    'Penyakit jantung mencakup berbagai kondisi yang mempengaruhi kesehatan jantung, '
                    'termasuk serangan jantung dan gagal jantung.',
              ),
              _buildInfoCard(
                title: 'BMI (Body Mass Index)',
                description:
                    'BMI adalah pengukuran yang digunakan untuk menentukan apakah berat badan Anda sehat berdasarkan tinggi badan. '
                    'BMI di atas 25 menunjukkan kelebihan berat badan atau obesitas.',
              ),
              _buildInfoCard(
                title: 'HbA1c Level',
                description:
                    'HbA1c adalah tes darah yang menunjukkan rata-rata kadar gula darah Anda selama 2-3 bulan terakhir. '
                    'Tes ini sering digunakan untuk diagnosis dan pemantauan diabetes.',
              ),
              _buildInfoCard(
                title: 'Blood Glucose Level (Kadar Glukosa Darah)',
                description:
                    'Kadar glukosa darah mengukur jumlah gula dalam darah Anda. '
                    'Kadar yang tinggi secara konsisten dapat menunjukkan risiko diabetes.',
              ),
              const SizedBox(height: 30),

              // Animasi Sederhana
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                  strokeWidth: 4,
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Analisis Data Kesehatan Anda...',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membangun kartu informasi
  Widget _buildInfoCard({required String title, required String description}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.all(16.0),
    width: double.infinity, // Mengatur lebar menjadi penuh sesuai layar
    decoration: BoxDecoration(
      color: Colors.blueAccent.withOpacity(0.1),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    ),
  );
  }
}