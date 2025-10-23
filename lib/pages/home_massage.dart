import 'package:app_distribuidora/models/massage.dart';
import 'package:app_distribuidora/pages/agendamento_page.dart';
import 'package:app_distribuidora/pages/dicas_page.dart';
import 'package:app_distribuidora/services/massage_service.dart';
import 'package:app_distribuidora/pages/sobre_page.dart';
import 'package:app_distribuidora/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';


class AppColors {
  static const Color primary = Color(0xFF795548);
  static const Color background = Color(0xFFFDFBF8);
  static const Color accent = Color(0xFFBCAAA4);
  static const Color text = Color(0xFF424242);
  static const Color textLight = Color(0xFF757575);
  static const Color surface = Colors.white;
}

class AppTextStyles {
  static final TextStyle headline1 = GoogleFonts.lora(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
  static final TextStyle headline2 = GoogleFonts.lora(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
  static final TextStyle bodyText = GoogleFonts.lato(
    fontSize: 16,
    color: AppColors.textLight,
    height: 1.5,
  );
  static final TextStyle button = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

void main() {
  runApp(const FlorDeLotusApp());
}

class FlorDeLotusApp extends StatelessWidget {
  const FlorDeLotusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flor de Lótus Massoterapia',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        textTheme: TextTheme(bodyMedium: AppTextStyles.bodyText),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;
  late final PageController _testimonialsController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _testimonialsController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _testimonialsController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const MainBanner(),
            FadeInUp(from: 30, child: const LegacySection()),
            FadeInUp(from: 30, child: const SessionsSection()),
            FadeInUp(
              from: 30,
              child: TestimonialsSection(controller: _testimonialsController),
            ),
            FadeInUp(from: 30, child: const TipsSection()),
            FadeInUp(from: 30, child: const CtaSection()),
            const Footer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToTop,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.arrow_upward_rounded),
      ),
    );
  }
}

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.8),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/logo2.png', height: 32),
                const SizedBox(width: 8),
                const Text(
                  'Flor de Lótus',
                  style: TextStyle(
                    color: Color.fromARGB(255, 96, 95, 95),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AgendamentoPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Agendar',
                style: AppTextStyles.button.copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MainBanner extends StatelessWidget {
  const MainBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const NetworkImage('assets/images/aroma.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: FadeInUp(
            from: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Descubra o Equilíbrio e o Bem-estar',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headline1.copyWith(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Um refúgio de tranquilidade e renovação com atendimento personalizado que supera todas as expectativas.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyText.copyWith(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LegacySection extends StatelessWidget {
  const LegacySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Text(
            'LEGADO & EXCELÊNCIA',
            style: AppTextStyles.bodyText.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'O Apogeu do Relaxamento',
            textAlign: TextAlign.center,
            style: AppTextStyles.headline2,
          ),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://images.pexels.com/photos/3757942/pexels-photo-3757942.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Há mais de uma década, criamos experiências restauradoras através de um serviço excepcional e atenção a cada detalhe. Nosso compromisso rendeu reconhecimento e a preferência de clientes que buscam alívio e renovação.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyText,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SobrePage()),
              );
            },
            icon: const Icon(Icons.arrow_forward_rounded, size: 18),
            label: Text(
              'Veja Mais',
              style: AppTextStyles.button.copyWith(fontSize: 14),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SessionsSection extends StatefulWidget {
  const SessionsSection({super.key});

  @override
  State<SessionsSection> createState() => _SessionsSectionState();
}

class _SessionsSectionState extends State<SessionsSection> {
  List<Massage> _massages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMassages();
  }

  Future<void> _fetchMassages() async {
    try {
      final fetchedMassages = await MassageService.getMassagens();
      setState(() {
        _massages = fetchedMassages;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Erro ao carregar massagens: $e');
    }
  }

  void _showMassageDetails(BuildContext context, Massage massage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(massage.nome ?? "Detalhes"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              massage.imagemUrl != null && massage.imagemUrl!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 90,
                        height: 90,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child:
                              massage.imagemUrl != null &&
                                  massage.imagemUrl!.isNotEmpty
                              ? Image.network(
                                  massage.imagemUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                        Icons.image_not_supported,
                                        color: AppColors.accent,
                                        size: 40,
                                      ),
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.primary,
                                          ),
                                        );
                                      },
                                )
                              : Container(
                                  width: 60,
                                  height: 60,
                                  color: AppColors.accent.withOpacity(0.2),
                                  child: Center(
                                    child: Icon(
                                      Icons.image,
                                      color: AppColors.primary,
                                      size: 40,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    )
                  : Icon(
                      Icons.image_not_supported,
                      size: 64,
                      color: AppColors.accent,
                    ),
              const SizedBox(height: 16),
              Text(
                massage.descricao ?? "Sem descrição detalhada.",
                style: AppTextStyles.bodyText.copyWith(
                  color: AppColors.text,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Fechar', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Nossas Sessões',
              style: AppTextStyles.headline2.copyWith(color: AppColors.text),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Explore nossas opções projetadas para seu bem-estar.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText,
            ),
          ),
          const SizedBox(height: 32),

          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : _massages.isEmpty
              ? Center(
                  child: Text(
                    'Nenhuma massagem disponível.',
                    style: AppTextStyles.bodyText,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _massages.length,
                  itemBuilder: (context, index) {
                    final massage = _massages[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child:
                                  massage.imagemUrl != null &&
                                      massage.imagemUrl!.isNotEmpty
                                  ? Image.network(
                                      massage.imagemUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) => Icon(
                                            Icons.image_not_supported,
                                            color: AppColors.accent,
                                            size: 40,
                                          ),
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.primary,
                                                value:
                                                    loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                    )
                                  : Container(
                                      color: AppColors.accent.withOpacity(0.2),
                                      child: Center(
                                        child: Icon(
                                          Icons.image,
                                          color: AppColors.primary,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          title: Text(
                            massage.nome ?? "Sem nome",
                            style: AppTextStyles.bodyText.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.text,
                            ),
                          ),
                          subtitle: Text(
                            massage.descricao ?? "Sem descrição",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodyText.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.primary,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AgendamentoPage(),
                                ),
                              );
                            },
                          ),
                          onTap: () {
                            _showMassageDetails(context, massage);
                          },
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}

class TestimonialsSection extends StatelessWidget {
  final PageController controller;
  const TestimonialsSection({super.key, required this.controller});

  static const List<Map<String, String>> testimonials = [
    {
      "name": "Mariana Costa",
      "role": "Massoterapeuta Sênior & Aromaterapeuta",
      "text":
          "Focamos na experiência de imersão. A excelência está na seleção dos óleos essenciais e na qualidade de nossas massagens.",
      "image":
          "https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?auto=compress&cs=tinysrgb&w=800",
    },
    {
      "name": "Lucas Pereira",
      "role": "Terapeuta Corporal & Idealizador do Espaço",
      "text":
          "Criamos um refúgio para você relaxar e se reconectar. Nossa equipe de massoterapeutas é altamente qualificada.",
      "image":
          "https://images.pexels.com/photos/846741/pexels-photo-846741.jpeg?auto=compress&cs=tinysrgb&w=800",
    },
    {
      "name": "Isabella Santos",
      "role": "Coordenadora de Bem-Estar & Atendimento",
      "text":
          "Qualidade e bem-estar são inegociáveis. Somos seu destino de paz, oferecendo alívio das tensões e um momento essencial de autocuidado.",
      "image":
          "https://images.pexels.com/photos/1036623/pexels-photo-1036623.jpeg?auto=compress&cs=tinysrgb&w=800",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        children: [
          Text('Profissionais', style: AppTextStyles.headline2),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Alguns comentarios de nossos profissionais',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 280,
            child: PageView.builder(
              controller: controller,
              itemCount: testimonials.length,
              itemBuilder: (context, index) {
                final testimonial = testimonials[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: _buildTestimonialCard(
                    name: testimonial['name']!,
                    role: testimonial['role']!,
                    text: testimonial['text']!,
                    imageUrl: testimonial['image']!,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildArrowButton(
                Icons.arrow_back,
                () => controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                ),
              ),
              const SizedBox(width: 16),
              _buildArrowButton(
                Icons.arrow_forward,
                () => controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard({
    required String name,
    required String role,
    required String text,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '"$text"',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyText.copyWith(
              fontStyle: FontStyle.italic,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 24),
          CircleAvatar(radius: 30, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(height: 8),
          Text(
            name,
            style: AppTextStyles.bodyText.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          Text(role, style: AppTextStyles.bodyText.copyWith(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildArrowButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: AppColors.primary),
      style: IconButton.styleFrom(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.accent),
        ),
      ),
    );
  }
}

// NOVO WIDGET: Seção de Dicas (TipsSection)
class TipsSection extends StatelessWidget {
  const TipsSection({super.key});

    @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: Column(
        children: [
          Text('Dicas Inspiradoras', style: AppTextStyles.headline2),
          const SizedBox(height: 8),
          Text(
            'Veja formas de melhorar seu dia a dia.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyText,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DicasPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.text,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text('Dicas', style: AppTextStyles.button),
          ),
        ],
      ),
    );
  }
}

class CtaSection extends StatelessWidget {
  const CtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.accent.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: Column(
        children: [
          Text('Pronto para Relaxar?', style: AppTextStyles.headline2),
          const SizedBox(height: 8),
          Text(
            'Agende sua sessão hoje e dê o primeiro passo para uma vida mais equilibrada e serena.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyText,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AgendamentoPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text('Agende Sua Visita', style: AppTextStyles.button),
          ),
        ],
      ),
    );
  }
}


class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.text.withOpacity(0.9),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        children: [
          Text(
            'Flor de Lótus',
            style: AppTextStyles.headline2.copyWith(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIcon(Icons.facebook),
              const SizedBox(width: 16),
              _socialIcon(Icons.camera_alt_outlined),
              const SizedBox(width: 16),
              _socialIcon(Icons.call),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '© 2025 Flor de Lótus. Todos os direitos reservados.',
            style: AppTextStyles.bodyText.copyWith(
              color: AppColors.accent,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Icon(icon, color: Colors.white, size: 24);
  }
}

// NOVA PÁGINA: Placeholder para Dicas Inspiradoras
class InspirationalTipsPage extends StatelessWidget {
  const InspirationalTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dicas Inspiradoras',
          style: AppTextStyles.headline2.copyWith(fontSize: 20),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.lightbulb_outline, size: 60, color: AppColors.primary),
              const SizedBox(height: 24),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                 onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DicasPage(),
                ),
              );
            },
                icon: const Icon(Icons.arrow_back, size: 18),
                label: Text('Voltar para a Home', style: AppTextStyles.button),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
