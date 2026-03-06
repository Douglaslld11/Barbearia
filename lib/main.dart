import 'package:flutter/material.dart';

void main() {
  runApp(const BarbeariaApp());
}

class BarbeariaApp extends StatelessWidget {
  const BarbeariaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barbearia App',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            elevation: 0,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // mantém os nomes dos serviços selecionados
  Set<String> selectedServices = {};

  final List<Service> services = [
    Service(name: 'Corte', price: 50.00, icon: Icons.content_cut),
    Service(name: 'Barba', price: 35.00, icon: Icons.face),
    Service(name: 'Sobrancelha', price: 20.00, icon: Icons.remove),
    // preço do combo já com desconto de 10%
    Service(name: 'Combo', price: (50.00 + 35.00 + 20.00) * 0.9, icon: Icons.star),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Barbearia Premium',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.content_cut,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Bem-vindo!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Escolha o serviço desejado e agende seu horário',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final service = services[index];
                  final isSelected = selectedServices.contains(service.name);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (service.name == 'Combo') {
                        selectedServices = {service.name};
                      } else {
                        if (selectedServices.contains('Combo')) {
                          selectedServices.clear();
                        }
                        if (selectedServices.contains(service.name)) {
                          selectedServices.remove(service.name);
                        } else {
                          selectedServices.add(service.name);
                        }
                        // verificar se os 3 serviços individuais foram selecionados
                        if (selectedServices.contains('Corte') &&
                            selectedServices.contains('Barba') &&
                            selectedServices.contains('Sobrancelha')) {
                          // substituir pelos 3 serviços com o combo
                          selectedServices = {'Combo'};
                        }
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withOpacity(0.1)
                          : const Color(0xFF1F1F1F),
                      border: Border.all(
                        color: isSelected
                            ? Colors.white.withOpacity(0.3)
                            : Colors.grey[800]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                            child: Icon(
                              service.icon,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  service.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Serviço de qualidade',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'R\$ ${service.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }, childCount: services.length),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          border: Border(top: BorderSide(color: Colors.grey[800]!, width: 1)),
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: selectedServices.isEmpty
                ? null
                : () {
                    _showConfirmationDialog(context);
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedServices.isEmpty
                  ? Colors.grey[700]
                  : Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'AGENDAR',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: selectedServices.isEmpty ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    // obter objetos de serviço selecionados
    final selectedObjs = services
        .where((s) => selectedServices.contains(s.name))
        .toList();
    double totalPrice;
    if (selectedServices.contains('Combo')) {
      totalPrice = selectedObjs
          .firstWhere((s) => s.name == 'Combo')
          .price; // já com desconto
    } else {
      totalPrice = selectedObjs.fold(0.0, (sum, s) => sum + s.price);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.white, width: 2),
          ),
          title: const Text(
            'Confirmação de Agendamento',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Você está agendando:',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 12),
              // listagem dos serviços escolhidos
              ...selectedObjs.map((service) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(service.icon,
                            color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            service.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          'R\$ ${service.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 12),
              Text(
                'Total: R\$ ${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Você será redirecionado para escolher data e horário.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'CANCELAR',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // navegar para página de agendamento usando lista de serviços
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SchedulePage(
                        services: selectedObjs, totalPrice: totalPrice),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text(
                'CONFIRMAR',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class Service {
  final String name;
  final double price;
  final IconData icon;

  Service({required this.name, required this.price, required this.icon});
}

class TimePickerDialog extends StatefulWidget {
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onTimeSelected;

  const TimePickerDialog({
    Key? key,
    required this.initialTime,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  State<TimePickerDialog> createState() => _TimePickerDialogState();
}

class _TimePickerDialogState extends State<TimePickerDialog> {
  late int selectedHour;
  late int selectedMinute;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initialTime.hour;
    selectedMinute = widget.initialTime.minute;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1F1F1F),
      title: const Text(
        'Escolher Horário',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Horas (08:00 - 18:00)',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _buildHourButtons(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Minutos',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _buildMinuteButtons(),
            ),
            const SizedBox(height: 20),
            Text(
              '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'CANCELAR',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onTimeSelected(
              TimeOfDay(hour: selectedHour, minute: selectedMinute),
            );
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          child: const Text(
            'CONFIRMAR',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildHourButtons() {
    final buttons = <Widget>[];
    for (int hour = 8; hour <= 18; hour++) {
      final isSelected = hour == selectedHour;
      buttons.add(
        ElevatedButton(
          onPressed: () {
            setState(() {
              selectedHour = hour;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected
                ? Colors.white
                : const Color(0xFF2F2F2F),
            foregroundColor: isSelected ? Colors.black : Colors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: Text(
            '${hour.toString().padLeft(2, '0')}:00',
            style: const TextStyle(fontSize: 12),
          ),
        ),
      );
    }
    return buttons;
  }

  List<Widget> _buildMinuteButtons() {
    final minutes = [0, 15, 30, 45];
    final buttons = <Widget>[];
    for (final min in minutes) {
      final isSelected = min == selectedMinute;
      buttons.add(
        ElevatedButton(
          onPressed: () {
            setState(() {
              selectedMinute = min;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected
                ? Colors.white
                : const Color(0xFF2F2F2F),
            foregroundColor: isSelected ? Colors.black : Colors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: Text(
            min.toString().padLeft(2, '0'),
            style: const TextStyle(fontSize: 12),
          ),
        ),
      );
    }
    return buttons;
  }
}

class SchedulePage extends StatefulWidget {
  final List<Service> services;
  final double totalPrice;
  const SchedulePage({Key? key, required this.services, required this.totalPrice})
      : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      selectableDayPredicate: (DateTime date) {
        // bloquear domingos (weekday 7 = domingo)
        return date.weekday != 7;
      },
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.white,
              onPrimary: Colors.black,
              surface: const Color(0xFF1F1F1F),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF121212),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    showDialog(
      context: context,
      builder: (context) => TimePickerDialog(
        initialTime: _selectedTime ?? const TimeOfDay(hour: 8, minute: 0),
        onTimeSelected: (time) {
          setState(() {
            _selectedTime = time;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendar ${widget.services.map((s) => s.name).join(', ')}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total: R\$ ${widget.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _pickDate,
              child: Text(_selectedDate == null
                  ? 'Escolher data'
                  : 'Data: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickTime,
              child: Text(_selectedTime == null
                  ? 'Escolher horário'
                  : 'Horário: ${_selectedTime!.format(context)}'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _selectedDate != null && _selectedTime != null
                  ? () {
                      final formattedDate =
                          '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
                      final formattedTime = _selectedTime!.format(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BarberSelectionPage(
                            services: widget.services,
                            totalPrice: widget.totalPrice,
                            selectedDate: formattedDate,
                            selectedTime: formattedTime,
                          ),
                        ),
                      );
                    }
                  : null,
              child: const Text('Próximo'),
            ),
          ],
        ),
      ),
    );
  }
}

class BarberSelectionPage extends StatefulWidget {
  final List<Service> services;
  final double totalPrice;
  final String selectedDate;
  final String selectedTime;

  const BarberSelectionPage({
    Key? key,
    required this.services,
    required this.totalPrice,
    required this.selectedDate,
    required this.selectedTime,
  }) : super(key: key);

  @override
  State<BarberSelectionPage> createState() => _BarberSelectionPageState();
}

class _BarberSelectionPageState extends State<BarberSelectionPage> {
  String? selectedBarber;

  final List<String> barbers = [
    'João Silva',
    'Carlos Santos',
    'Pedro Oliveira',
    'Bruno Costa'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolher Barbeiro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Data: ${widget.selectedDate}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Horário: ${widget.selectedTime}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Total: R\$ ${widget.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Selecione seu barbeiro:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: barbers.length,
                itemBuilder: (context, index) {
                  final barber = barbers[index];
                  final isSelected = selectedBarber == barber;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedBarber = barber;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withOpacity(0.1)
                            : const Color(0xFF1F1F1F),
                        border: Border.all(
                          color: isSelected
                              ? Colors.white.withOpacity(0.3)
                              : Colors.grey[800]!,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  barber,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Barbeiro experiente',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          border: Border(
            top: BorderSide(color: Colors.grey[800]!, width: 1),
          ),
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: selectedBarber == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PaymentMethodPage(
                          services: widget.services,
                          totalPrice: widget.totalPrice,
                          selectedDate: widget.selectedDate,
                          selectedTime: widget.selectedTime,
                          selectedBarber: selectedBarber!,
                        ),
                      ),
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedBarber == null
                  ? Colors.grey[700]
                  : Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'CONFIRMAR AGENDAMENTO',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: selectedBarber == null ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentMethodPage extends StatelessWidget {
  final List<Service> services;
  final double totalPrice;
  final String selectedDate;
  final String selectedTime;
  final String selectedBarber;

  const PaymentMethodPage({
    Key? key,
    required this.services,
    required this.totalPrice,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedBarber,
  }) : super(key: key);

  String _generatePixLink() {
    final formattedAmount = totalPrice.toStringAsFixed(2);
    return 'PIX BR SBRF30a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8-$formattedAmount';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Método de Pagamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resumo do Agendamento',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Data: $selectedDate | Horário: $selectedTime',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Barbeiro: $selectedBarber',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Total: R\$ ${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Escolha o método de pagamento:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildPaymentOption(
                    context,
                    title: 'PIX',
                    subtitle: 'Pagamento instantâneo',
                    icon: Icons.qr_code,
                    onTap: () => _showPixDialog(context),
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentOption(
                    context,
                    title: 'Cartão de Crédito',
                    subtitle: 'Aguardará aprovação',
                    icon: Icons.credit_card,
                    onTap: () => _showWaitingApprovalDialog(context, 'Cartão'),
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentOption(
                    context,
                    title: 'Dinheiro',
                    subtitle: 'Pagamento no local',
                    icon: Icons.money,
                    onTap: () => _showWaitingApprovalDialog(context, 'Dinheiro'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          border: Border.all(color: Colors.grey[800]!, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showPixDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PaymentPixDialog(
        pixLink: _generatePixLink(),
        totalPrice: totalPrice,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        selectedBarber: selectedBarber,
      ),
    );
  }

  void _showWaitingApprovalDialog(BuildContext context, String method) {
    showDialog(
      context: context,
      builder: (context) => PaymentWaitingDialog(
        method: method,
        totalPrice: totalPrice,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        selectedBarber: selectedBarber,
      ),
    );
  }
}

class PaymentPixDialog extends StatefulWidget {
  final String pixLink;
  final double totalPrice;
  final String selectedDate;
  final String selectedTime;
  final String selectedBarber;

  const PaymentPixDialog({
    Key? key,
    required this.pixLink,
    required this.totalPrice,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedBarber,
  }) : super(key: key);

  @override
  State<PaymentPixDialog> createState() => _PaymentPixDialogState();
}

class _PaymentPixDialogState extends State<PaymentPixDialog> {
  bool _paymentConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1F1F1F),
      title: const Text(
        'Pagamento com PIX',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total: R\$ ${widget.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2F2F2F),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Link PIX para copiar:',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  SelectableText(
                    widget.pixLink,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text(
                'Confirmar pagamento realizado',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              value: _paymentConfirmed,
              onChanged: (value) {
                setState(() {
                  _paymentConfirmed = value ?? false;
                });
              },
              checkColor: Colors.white,
              activeColor: Colors.white,
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'CANCELAR',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: _paymentConfirmed
              ? () {
                  Navigator.pop(context);
                  _showPaymentSuccessDialog(context);
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _paymentConfirmed
                ? Colors.white
                : Colors.grey[700],
          ),
          child: Text(
            'CONFIRMAR',
            style: TextStyle(
              color: _paymentConfirmed ? Colors.black : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: const Text(
          '✓ Pagamento Confirmado!',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 60,
            ),
            const SizedBox(height: 16),
            const Text(
              'Seu agendamento foi confirmado!',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Data: ${widget.selectedDate}\\nHorário: ${widget.selectedTime}\\nBarbeiro: ${widget.selectedBarber}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: const Text(
              'VOLTAR À TELA INICIAL',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentWaitingDialog extends StatelessWidget {
  final String method;
  final double totalPrice;
  final String selectedDate;
  final String selectedTime;
  final String selectedBarber;

  const PaymentWaitingDialog({
    Key? key,
    required this.method,
    required this.totalPrice,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedBarber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1F1F1F),
      title: Text(
        'Pagamento com $method',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Total: R\$ ${totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.schedule,
                  color: Colors.white,
                  size: 48,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Aguardando Aprovação',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Seu agendamento será confirmado após a aprovação do pagamento',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Data: $selectedDate\\nHorário: $selectedTime\\nBarbeiro: $selectedBarber',
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Agendamento pendente aprovação via $method. Você receberá uma confirmação em breve.',
                  style: const TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white,
                duration: const Duration(seconds: 3),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

