import 'package:app_distribuidora/pages/agendamento_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DicasPage extends StatelessWidget {
  const DicasPage({Key? key}) : super(key: key);

  // Define a paleta de cores baseada na imagem
  static const Color primaryBrown = Color(0xFF8D6E63); // Marrom do botão "Agendar"
  static const Color darkBrown = Color(0xFF4E342E);   // Marrom escuro para textos
  static const Color lightBeige = Color(0xFFFAF7F0);   // Fundo bege claro
  static const Color goldAccent = Color(0xFFBCAAA4); // Um tom suave para ícones

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBeige,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(),
            _buildContentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        // Imagem de fundo (substitua pela sua)
        Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1544161515-cfd89f8f974c?fit=crop&w=1200&q=80',
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), // Escurece a imagem
                BlendMode.darken,
              ),
            ),
          ),
        ),
        // Textos da Hero
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dicas Inspiradoras',
                style: GoogleFonts.playfairDisplay(
                  color: darkBrown,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Pequenas mudanças para um dia a dia com mais equilíbrio e bem-estar.',
                style: GoogleFonts.lato(
                  color: darkBrown,
                  fontSize: 18,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título da Seção (similar ao "LEGADO & EXCELÊNCIA")
          Text(
            'SUA JORNADA DIÁRIA',
            style: GoogleFonts.lato(
              color: primaryBrown,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          // Título Principal (similar ao "O Apogeu do Relaxamento")
          Text(
            'Cultivando o Bem-Estar',
            style: GoogleFonts.playfairDisplay(
              color: darkBrown,
              fontSize: 34,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 24),
          // Lista de Dicas
          _buildTipCard(
            icon: Icons.accessibility_new,
            title: 'Consciência Corporal',
            description:
                'Preste atenção à sua postura. Sente-se e ande com a coluna ereta. Ombros relaxados e para trás. Isso por si só já alivia grande parte da tensão muscular diária.',
          ),
          _buildTipCard(
            icon: Icons.air,
            title: 'Respiração Pausada',
            description:
                'De tempos em tempos, pare por 1 minuto. Feche os olhos. Inspire profundamente pelo nariz contando até 4, segure o ar por 4 segundos e expire lentamente pela boca contando até 6. Repita 5x.',
          ),
          _buildTipCard(
            icon: Icons.spa,
            title: 'Alongamento Rápido',
            description:
                'Ao acordar, antes mesmo de levantar, estique braços e pernas. Gire o pescoço suavemente. Movimentos simples "acordam" a musculatura e previnem rigidez.',
          ),
          _buildTipCard(
            icon: Icons.water_drop_outlined,
            title: 'Hidratação é Chave',
            description:
                'Músculos desidratados são músculos tensos. Tenha sempre uma garrafa de água por perto. A hidratação adequada é fundamental para a função muscular e eliminação de toxinas.',
          ),
          _buildTipCard(
            icon: Icons.pan_tool_outlined,
            title: 'Automassagem nos Pés',
            description:
                'Use uma bola de tênis ou de massagem no chão e role-a sob a sola dos pés enquanto estiver sentado trabalhando. Isso estimula pontos de reflexologia e alivia a tensão de todo o corpo.',
          ),
          _buildTipCard(
            icon: Icons.bedtime_outlined,
            title: 'Desconexão Noturna',
            description:
                'Pelo menos 30 minutos antes de dormir, desligue telas (celular, TV). Use esse tempo para uma automassagem suave nas mãos com um creme hidratante ou para ler um livro.',
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para criar os cards de dicas
  Widget _buildTipCard(
      {required IconData icon,
      required String title,
      required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: goldAccent, size: 36),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lato(
                    color: darkBrown,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  description,
                  style: GoogleFonts.lato(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 16,
                    height: 1.5, // Espaçamento entre linhas
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}