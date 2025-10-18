import 'package:app_distribuidora/pages/home_massage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_distribuidora/models/massage.dart';
import 'package:app_distribuidora/services/massage_service.dart';

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({Key? key}) : super(key: key);

  @override
  _AgendamentoPageState createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _contatoController = TextEditingController();
  final TextEditingController _dataNascimentoController = TextEditingController();
  final TextEditingController _dataAtendimentoController = TextEditingController();

  List<Massage> _massages = [];
  Massage? _massagemSelecionada;
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

  Future<void> _selecionarData(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _contatoController.dispose();
    _dataNascimentoController.dispose();
    _dataAtendimentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F2ED),
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1C),
        elevation: 0,
         title: Align(
          alignment: Alignment.centerLeft, 
          child: InkWell(
            onTap: () {
                 Navigator.push(context,MaterialPageRoute(builder: (context) => const HomePage()),
    );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min, 
              children: [
                Image.asset(
                  'assets/images/logo2.png', 
                  height: 32, 
                ),
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSection('Dados do Paciente', _buildPatientInfo()),
              SizedBox(height: 16),
              _buildSection('Massagem', _buildMassageSection()),
              SizedBox(height: 16),
              _buildSection('Histórico de Saúde', _buildHealthHistorySection()),
              SizedBox(height: 16),
              _buildSection('Pedidos Especiais / Observações', _buildSpecialRequests()),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.check, color: Colors.white),
                  label: Text('FINALIZAR AGENDAMENTO', style: TextStyle(color: Colors.white)),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Color(0xFF6B5B4B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
          SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildPatientInfo() {
    return Column(
      children: [
        TextField(
          controller: _nomeController,
          decoration: InputDecoration(
            labelText: 'Nome Completo',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        SizedBox(height: 12),
        TextField(
          controller: _contatoController,
          decoration: InputDecoration(
            labelText: 'Endereço',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        SizedBox(height: 12),
        _buildDateField('Data de Nascimento', _dataNascimentoController),
      ],
    );
  }

  Widget _buildMassageSection() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        DropdownButtonFormField<Massage>(
          value: _massagemSelecionada,
          items: _massages.map((massage) {
            return DropdownMenuItem(
              value: massage,
              child: Text(massage.nome ?? ''), 
            );
          }).toList(),
          onChanged: (val) {
            setState(() => _massagemSelecionada = val);
          },
          decoration: InputDecoration(
            labelText: 'Tipo de Massagem',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        SizedBox(height: 12),
        TextField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Descreva áreas de foco ou restrições...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildHealthHistorySection() {
    return TextField(
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Condições médicas, alergias ou medicações...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildSpecialRequests() {
    return TextField(
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Informações adicionais que deseja compartilhar...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'dd/mm/aaaa',
            suffixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          onTap: () => _selecionarData(context, controller),
        ),
      ],
    );
  }
}
