import 'package:app_distribuidora/pages/agendamento_page.dart';
import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1C),
        elevation: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/logo2.png', height: 32),
                const SizedBox(width: 8),
                const Text(
                  'Flor de Lótus',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AgendamentoPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFC4A484),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Agende', style: TextStyle(color: Colors.black87)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [_buildSobreBanner(), _buildMainContent()]),
      ),
    );
  }

  Widget _buildSobreBanner() {
    return Container(
      width: double.infinity,
      color: Color(0xFF1C1C1C),
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: [
          Text(
            'Sobre',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Descubra o luxo e o conforto que só o Flor de Lótus oferece para você.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Início / Sobre',
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      color: Color(0xFFF5F2ED),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Luxo redefinido no coração do paraíso',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'O Hotel Flor de Lótus é o destino perfeito para quem busca conforto, elegância e bem-estar em um só lugar. Inspirado na beleza e no significado da flor de lótus — símbolo de pureza, renovação e harmonia —, nosso hotel oferece uma experiência única, onde cada detalhe foi pensado para acolher e encantar.\n\nAqui, você encontrará conforto, atendimento personalizado e uma experiência única que vai além das suas expectativas.',
            style: TextStyle(fontSize: 16, color: Colors.black54, height: 1.5),
          ),
          SizedBox(height: 24),

          Row(
            children: [
              Expanded(child: _buildStatCard('34', 'Anos de excelência')),
              SizedBox(width: 16),
              Expanded(child: _buildStatCard('2000+', 'Hóspedes satisfeitos')),
            ],
          ),
          SizedBox(height: 24.0),
          SizedBox(
            width: 500.0,
            height: 500.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset('assets/images/sobre.png', fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
