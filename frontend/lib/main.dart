import 'package:flutter/material.dart';

void main() {
  runApp(const KerDoctorApp());
}

class K {
  static const orange     = Color(0xFFE8621A);
  static const orangeLight= Color(0xFFFFF3EC);
  static const orangeDark = Color(0xFFC44E0F);
  static const navy       = Color(0xFF1A2B4A);
  static const dark       = Color(0xFF0F1E36);
  static const gray       = Color(0xFF64748B);
  static const grayLight  = Color(0xFFF1F5F9);
  static const grayBorder = Color(0xFFE2E8F0);
  static const white      = Colors.white;
  static const green      = Color(0xFF16A34A);
  static const greenBg    = Color(0xFFDCFCE7);
  static const red        = Color(0xFFDC2626);
  static const yellow     = Color(0xFFD97706);
  static const yellowBg   = Color(0xFFFEF3C7);
  static const teal       = Color(0xFF0D9488);
}

class KerDoctorApp extends StatelessWidget {
  const KerDoctorApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KerDoctor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: K.orange),
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: K.grayLight,
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: K.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                const Text('KerDoctor', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: K.navy)),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity, height: 220,
                  decoration: BoxDecoration(color: K.orangeLight, borderRadius: BorderRadius.circular(20)),
                  child: const Center(child: Icon(Icons.medical_services_rounded, size: 100, color: K.orange)),
                ),
                const SizedBox(height: 28),
                const Text('Welcome', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: K.navy)),
                const SizedBox(height: 6),
                const Text('Dalal ak jamm', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: K.orange)),
                const SizedBox(height: 10),
                const Text('Choose your language to get started with\nbetter healthcare.', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: K.gray, height: 1.5)),
                const SizedBox(height: 32),
                _langBtn(context, icon: Icons.translate_rounded, title: 'Francais', subtitle: 'French', selected: true),
                const SizedBox(height: 12),
                _langBtn(context, icon: Icons.language_rounded, title: 'Wolof', subtitle: 'Wolof', selected: false),
                const SizedBox(height: 12),
                _langBtn(context, icon: Icons.record_voice_over_rounded, title: 'Pulaar', subtitle: 'Fula', selected: false),
                const SizedBox(height: 20),
                const Text('Tap on a language to continue', style: TextStyle(fontSize: 13, color: K.gray)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _langBtn(BuildContext context, {required IconData icon, required String title, required String subtitle, required bool selected}) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen())),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: selected ? K.orange : K.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? K.orange : K.grayBorder, width: 1.5),
          boxShadow: selected ? [BoxShadow(color: K.orange.withOpacity(0.25), blurRadius: 12)] : [],
        ),
        child: Row(children: [
          Icon(icon, color: selected ? K.white : K.gray, size: 26),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(color: selected ? K.white : K.navy, fontSize: 16, fontWeight: FontWeight.bold)),
            Text(subtitle, style: TextStyle(color: selected ? K.white.withOpacity(0.8) : K.gray, fontSize: 13)),
          ])),
          Icon(Icons.chevron_right_rounded, color: selected ? K.white : K.gray),
        ]),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: K.grayLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            Row(children: [
              Container(width: 48, height: 48, decoration: BoxDecoration(shape: BoxShape.circle, color: K.orangeLight, border: Border.all(color: K.orange, width: 2)), child: const Icon(Icons.person_rounded, color: K.orange)),
              const SizedBox(width: 12),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Welcome back,', style: TextStyle(color: K.gray, fontSize: 13)),
                Text('Moussa Diop', style: TextStyle(color: K.navy, fontSize: 18, fontWeight: FontWeight.bold)),
              ])),
              Stack(children: [
                const Icon(Icons.notifications_rounded, color: K.navy, size: 28),
                Positioned(right: 0, top: 0, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: K.red, shape: BoxShape.circle))),
              ]),
            ]),
            const SizedBox(height: 24),
            Container(
              width: double.infinity, padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(color: K.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16)]),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Start your consultation', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: K.navy, height: 1.3)),
                const SizedBox(height: 8),
                RichText(text: const TextSpan(text: 'Get professional medical advice instantly. Flat fee of ', style: TextStyle(color: K.gray, fontSize: 14), children: [
                  TextSpan(text: '2500 FCFA', style: TextStyle(color: K.orange, fontWeight: FontWeight.bold)),
                  TextSpan(text: '. No hidden costs.'),
                ])),
                const SizedBox(height: 16),
                Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), decoration: BoxDecoration(color: K.orangeLight, borderRadius: BorderRadius.circular(12)), child: const Row(children: [
                  Icon(Icons.wallet_rounded, color: K.orange, size: 20),
                  SizedBox(width: 10),
                  Text('Consultation Fee', style: TextStyle(color: K.orange, fontSize: 14)),
                  Spacer(),
                  Text('2,500 FCFA', style: TextStyle(color: K.navy, fontSize: 16, fontWeight: FontWeight.bold)),
                ])),
                const SizedBox(height: 14),
                SizedBox(width: double.infinity, height: 52, child: ElevatedButton.icon(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SymptomScreen())),
                  icon: const Icon(Icons.medical_services_rounded),
                  label: const Text('Talk to a Doctor', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(backgroundColor: K.orange, foregroundColor: K.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 0),
                )),
              ]),
            ),
            const SizedBox(height: 24),
            const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: K.navy)),
            const SizedBox(height: 14),
            GridView.count(
              crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.5,
              children: [
                _qCard(context, Icons.receipt_long_rounded, 'My Prescriptions', '2 active items', K.orange, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RemindersScreen()))),
                _qCard(context, Icons.alarm_rounded, 'Medication\nReminders', 'Next at 2:00 PM', K.yellow, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RemindersScreen()))),
                _qCard(context, Icons.history_rounded, 'History', 'Past visits', K.teal, () {}),
                _qCard(context, Icons.support_agent_rounded, 'Support', 'Help center', K.gray, () {}),
              ],
            ),
            const SizedBox(height: 20),
            Container(width: double.infinity, padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: K.orange, borderRadius: BorderRadius.circular(16)), child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.lightbulb_rounded, color: K.white, size: 24),
              SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Health Tip of the Day', style: TextStyle(color: K.white, fontWeight: FontWeight.bold, fontSize: 15)),
                SizedBox(height: 6),
                Text('Stay hydrated in the heat. Drink at least 2 liters of water daily to maintain energy levels.', style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5)),
              ])),
            ])),
            const SizedBox(height: 30),
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: K.orange, unselectedItemColor: K.gray, currentIndex: 0, type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.medical_services), label: 'Consults'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _qCard(BuildContext ctx, IconData icon, String title, String sub, Color color, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: K.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 22)),
      const SizedBox(height: 8),
      Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: K.navy, height: 1.3)),
      Text(sub, style: const TextStyle(fontSize: 11, color: K.gray)),
    ])));
  }
}

class SymptomScreen extends StatefulWidget {
  const SymptomScreen({super.key});
  @override
  State<SymptomScreen> createState() => _SymptomScreenState();
}

class _SymptomScreenState extends State<SymptomScreen> with SingleTickerProviderStateMixin {
  bool _recording = false;
  bool _hasRecording = false;
  late AnimationController _ctrl;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..repeat(reverse: true);
    _pulse = Tween<double>(begin: 1.0, end: 1.15).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: K.grayLight,
      appBar: AppBar(backgroundColor: K.white, elevation: 0.5, leading: IconButton(icon: const Icon(Icons.arrow_back, color: K.navy), onPressed: () => Navigator.pop(context)), title: const Text('Symptom Check', style: TextStyle(color: K.navy, fontWeight: FontWeight.bold, fontSize: 17)), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Describe how you feel', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: K.navy)),
          const SizedBox(height: 10),
          const Text('Tap the microphone and speak clearly in\nyour preferred language (Wolof, French, or English).', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: K.gray, height: 1.6)),
          const SizedBox(height: 40),
          if (_recording)
            Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(11, (i) {
              final h = [16.0, 28.0, 40.0, 32.0, 48.0, 36.0, 48.0, 32.0, 40.0, 28.0, 16.0];
              return Container(margin: const EdgeInsets.symmetric(horizontal: 2.5), width: 4, height: h[i], decoration: BoxDecoration(color: K.orange, borderRadius: BorderRadius.circular(4)));
            }))
          else const SizedBox(height: 48),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: () => setState(() { if (!_recording) { _recording = true; _hasRecording = false; } else { _recording = false; _hasRecording = true; } }),
            child: AnimatedBuilder(
              animation: _pulse,
              builder: (_, child) => Transform.scale(scale: _recording ? _pulse.value : 1.0, child: child),
              child: Container(width: 120, height: 120, decoration: BoxDecoration(shape: BoxShape.circle, color: K.orange, boxShadow: [BoxShadow(color: K.orange.withOpacity(0.35), blurRadius: 30, spreadRadius: 8)]),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(_recording ? Icons.stop_rounded : Icons.mic_rounded, color: K.white, size: 48),
                  if (_recording) const Text('REC', style: TextStyle(color: K.white, fontSize: 11, fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(_recording ? 'Listening...' : (_hasRecording ? 'Recording ready' : ''), style: TextStyle(color: _recording ? K.orange : K.green, fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 32),
          if (_hasRecording || _recording) Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _ctrlBtn(Icons.stop_rounded, 'Stop', () => setState(() { _recording = false; _hasRecording = true; })),
            const SizedBox(width: 16),
            _ctrlBtn(Icons.play_arrow_rounded, 'Playback', () {}),
            const SizedBox(width: 16),
            _ctrlBtn(Icons.delete_rounded, 'Clear', () => setState(() { _recording = false; _hasRecording = false; })),
          ]),
          const SizedBox(height: 32),
          SizedBox(width: double.infinity, height: 54, child: ElevatedButton(
            onPressed: _hasRecording ? () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TriageScreen())) : null,
            style: ElevatedButton.styleFrom(backgroundColor: K.orange, foregroundColor: K.white, disabledBackgroundColor: K.grayBorder, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 0),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Analyze Symptoms', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              SizedBox(width: 8), Icon(Icons.arrow_forward_rounded),
            ]),
          )),
        ]),
      ),
    );
  }

  Widget _ctrlBtn(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), decoration: BoxDecoration(color: K.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: K.grayBorder)), child: Column(children: [Icon(icon, size: 22, color: K.navy), const SizedBox(height: 4), Text(label, style: const TextStyle(fontSize: 12, color: K.gray))])));
  }
}

class TriageScreen extends StatelessWidget {
  const TriageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: K.grayLight,
      appBar: AppBar(backgroundColor: K.white, elevation: 0.5, leading: IconButton(icon: const Icon(Icons.arrow_back, color: K.navy), onPressed: () => Navigator.pop(context)), title: const Text('Triage Result', style: TextStyle(color: K.navy, fontWeight: FontWeight.bold, fontSize: 17)), centerTitle: true),
      body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: double.infinity, padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: K.yellowBg, borderRadius: BorderRadius.circular(18)), child: Column(children: [
          Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: K.yellow.withOpacity(0.2), shape: BoxShape.circle), child: const Icon(Icons.warning_rounded, color: K.yellow, size: 32)),
          const SizedBox(height: 14),
          const Text('Urgency: Moderate', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: K.navy)),
          const SizedBox(height: 8),
          const Text('Based on your reported symptoms, you\nshould consult a doctor within 24 hours.', textAlign: TextAlign.center, style: TextStyle(color: K.gray, fontSize: 14, height: 1.5)),
        ])),
        const SizedBox(height: 14),
        Container(width: double.infinity, height: 80, decoration: BoxDecoration(color: K.navy, borderRadius: BorderRadius.circular(14)), child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.medical_services_rounded, color: K.white, size: 22), SizedBox(width: 10),
          Text('Recommendation: Medical Consultation', style: TextStyle(color: K.white, fontWeight: FontWeight.w600, fontSize: 14)),
        ])),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Symptom Summary', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: K.navy)),
          Text('Edit', style: const TextStyle(fontSize: 14, color: K.orange, fontWeight: FontWeight.w600)),
        ]),
        const SizedBox(height: 12),
        Container(decoration: BoxDecoration(color: K.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]), child: Column(children: [
          _symRow(Icons.thermostat_rounded, K.orange, 'High Fever', 'Recorded temperature: 38.5 C'),
          const Divider(height: 1, indent: 16),
          _symRow(Icons.sick_rounded, K.yellow, 'Nausea & Vomiting', 'Started 2 days ago, intermittent'),
          const Divider(height: 1, indent: 16),
          _symRow(Icons.water_drop_rounded, K.teal, 'Dehydration Signs', 'Dry mouth, dizziness when standing'),
        ])),
        const SizedBox(height: 20),
        const Text('Next Steps', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: K.navy)),
        const SizedBox(height: 12),
        _step(1, 'Prepare your medical ID card'),
        const SizedBox(height: 8),
        _step(2, 'Drink water while waiting'),
        const SizedBox(height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Consultation Fee', style: TextStyle(color: K.gray, fontSize: 14)),
          const Text('2,500 CFA', style: TextStyle(color: K.navy, fontSize: 18, fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 14),
        SizedBox(width: double.infinity, height: 54, child: ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutScreen())),
          style: ElevatedButton.styleFrom(backgroundColor: K.orange, foregroundColor: K.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 0),
          child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Proceed to Payment', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)), SizedBox(width: 8), Icon(Icons.arrow_forward_rounded)]),
        )),
        const SizedBox(height: 20),
      ])),
    );
  }
  Widget _symRow(IconData icon, Color color, String t, String s) => Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), child: Row(children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 20)), const SizedBox(width: 14), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(t, style: const TextStyle(fontWeight: FontWeight.bold, color: K.navy, fontSize: 14)), Text(s, style: const TextStyle(color: K.gray, fontSize: 12))])]));
  Widget _step(int n, String t) => Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), decoration: BoxDecoration(color: K.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: K.grayBorder)), child: Row(children: [Container(width: 28, height: 28, decoration: BoxDecoration(color: K.orangeLight, shape: BoxShape.circle), child: Center(child: Text('$n', style: const TextStyle(color: K.orange, fontWeight: FontWeight.bold, fontSize: 13)))), const SizedBox(width: 14), Expanded(child: Text(t, style: const TextStyle(color: K.navy, fontSize: 14))), const Icon(Icons.chevron_right_rounded, color: K.gray)]));
}

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}
class _CheckoutScreenState extends State<CheckoutScreen> {
  int _sel = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: K.grayLight,
      appBar: AppBar(backgroundColor: K.white, elevation: 0.5, leading: IconButton(icon: const Icon(Icons.arrow_back, color: K.navy), onPressed: () => Navigator.pop(context)), title: const Text('Checkout', style: TextStyle(color: K.navy, fontWeight: FontWeight.bold, fontSize: 17)), centerTitle: true),
      body: Padding(padding: const EdgeInsets.all(24), child: Column(children: [
        const SizedBox(height: 20),
        const Text('TOTAL AMOUNT', style: TextStyle(color: K.gray, fontSize: 13, letterSpacing: 1.2, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        const Text('2 500 FCFA', style: TextStyle(color: K.orange, fontSize: 38, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.medical_services_rounded, color: K.gray, size: 16), SizedBox(width: 6), Text('Consultation Fee', style: TextStyle(color: K.gray, fontSize: 14))]),
        const SizedBox(height: 28),
        const Text('Select your mobile money provider to securely\ncomplete your payment.', textAlign: TextAlign.center, style: TextStyle(color: K.gray, fontSize: 14, height: 1.6)),
        const SizedBox(height: 24),
        _pay(0, Icons.waves_rounded, const Color(0xFF00A3E0), 'Wave', 'Pay with 1% fees'),
        const SizedBox(height: 14),
        _pay(1, Icons.currency_exchange_rounded, const Color(0xFFFF6600), 'Orange Money', 'Standard rates apply'),
        const Spacer(),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.lock_rounded, color: K.gray, size: 16), SizedBox(width: 6), Text('Payments are secure and encrypted', style: TextStyle(color: K.gray, fontSize: 13))]),
        const SizedBox(height: 16),
        SizedBox(width: double.infinity, height: 54, child: ElevatedButton(
          onPressed: _sel >= 0 ? () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FindDoctorScreen())) : null,
          style: ElevatedButton.styleFrom(backgroundColor: K.orange, foregroundColor: K.white, disabledBackgroundColor: K.grayBorder, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 0),
          child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Pay 2 500 FCFA', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)), SizedBox(width: 8), Icon(Icons.arrow_forward_rounded)]),
        )),
        const SizedBox(height: 10),
      ])),
    );
  }
  Widget _pay(int idx, IconData icon, Color color, String title, String sub) {
    final sel = _sel == idx;
    return GestureDetector(onTap: () => setState(() => _sel = idx), child: Container(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16), decoration: BoxDecoration(color: K.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: sel ? K.orange : K.grayBorder, width: sel ? 2 : 1), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]), child: Row(children: [
      Container(width: 52, height: 52, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: K.white, size: 26)),
      const SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: K.navy)), Text(sub, style: const TextStyle(color: K.gray, fontSize: 13))])),
      Radio(value: idx, groupValue: _sel, activeColor: K.orange, onChanged: (v) => setState(() => _sel = v!)),
    ])));
  }
}

class FindDoctorScreen extends StatelessWidget {
  const FindDoctorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: K.grayLight,
      appBar: AppBar(backgroundColor: K.white, elevation: 0.5, leading: IconButton(icon: const Icon(Icons.arrow_back, color: K.navy), onPressed: () => Navigator.pop(context)), title: const Text('Finding a Doctor', style: TextStyle(color: K.navy, fontWeight: FontWeight.bold, fontSize: 17)), centerTitle: true),
      body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(child: Container(width: 180, height: 180, decoration: BoxDecoration(shape: BoxShape.circle, color: K.orangeLight, border: Border.all(color: K.orange.withOpacity(0.2), width: 16)), child: Container(margin: const EdgeInsets.all(20), decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [K.orange, K.orangeDark], begin: Alignment.topLeft, end: Alignment.bottomRight)), child: const Icon(Icons.monitor_heart_rounded, color: K.white, size: 56)))),
        const SizedBox(height: 20),
        const Center(child: Text('Finding the best doctor for you...', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: K.navy))),
        const SizedBox(height: 8),
        const Center(child: Text('Please wait while we match you with a specialist\nwho speaks your language (Wolof, French).', textAlign: TextAlign.center, style: TextStyle(color: K.gray, fontSize: 13, height: 1.5))),
        const SizedBox(height: 16),
        Center(child: Container(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), decoration: BoxDecoration(color: K.grayLight, borderRadius: BorderRadius.circular(12), border: Border.all(color: K.grayBorder)), child: const Text('Cancel Request', style: TextStyle(color: K.gray, fontWeight: FontWeight.w600, fontSize: 14)))),
        const SizedBox(height: 28),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Matched Doctors', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: K.navy)),
          Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: K.greenBg, borderRadius: BorderRadius.circular(20)), child: const Text('2 Available Now', style: TextStyle(color: K.green, fontSize: 12, fontWeight: FontWeight.w600))),
        ]),
        const SizedBox(height: 14),
        _doc(context, 'Dr. Amadou Fall', 'General Practitioner', '4.8', 'Wolof, French'),
        const SizedBox(height: 12),
        _doc(context, 'Dr. Aminata Diop', 'Pediatrician', '4.9', 'Wolof, French, English'),
      ])),
      bottomNavigationBar: BottomNavigationBar(selectedItemColor: K.orange, unselectedItemColor: K.gray, currentIndex: 1, type: BottomNavigationBarType.fixed, items: const [BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'), BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Find Doc'), BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded), label: 'Visits'), BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: 'Chat'), BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile')]),
    );
  }
  Widget _doc(BuildContext ctx, String name, String spec, String rating, String langs) => Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: K.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]), child: Column(children: [
    Row(children: [
      Container(width: 52, height: 52, decoration: BoxDecoration(shape: BoxShape.circle, color: K.orangeLight, border: Border.all(color: K.orange, width: 1.5)), child: const Icon(Icons.person_rounded, color: K.orange, size: 28)),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: K.navy)), Text(spec, style: const TextStyle(color: K.orange, fontSize: 13)), Row(children: [const Icon(Icons.translate_rounded, size: 13, color: K.gray), const SizedBox(width: 4), Text(langs, style: const TextStyle(color: K.gray, fontSize: 12))])])),
      Row(children: [const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 16), const SizedBox(width: 4), Text(rating, style: const TextStyle(fontWeight: FontWeight.bold, color: K.navy, fontSize: 14))]),
    ]),
    const SizedBox(height: 14),
    SizedBox(width: double.infinity, height: 46, child: ElevatedButton.icon(
      onPressed: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => VideoCallScreen(doctorName: name))),
      icon: const Icon(Icons.videocam_rounded, size: 20),
      label: const Text('Connect Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      style: ElevatedButton.styleFrom(backgroundColor: K.orange, foregroundColor: K.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
    )),
  ]));
}

class VideoCallScreen extends StatelessWidget {
  final String doctorName;
  const VideoCallScreen({super.key, required this.doctorName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, body: Stack(children: [
      Container(width: double.infinity, height: double.infinity, color: const Color(0xFFE8F4F0), child: const Center(child: Icon(Icons.person_rounded, size: 180, color: Color(0xFFB0C4D8)))),
      SafeArea(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), shape: BoxShape.circle), child: const Icon(Icons.arrow_back, color: K.navy, size: 20))),
        Column(children: [Text(doctorName, style: const TextStyle(color: K.white, fontWeight: FontWeight.bold, fontSize: 16, shadows: [Shadow(color: Colors.black45, blurRadius: 8)])), const Row(children: [Icon(Icons.circle, color: K.green, size: 10), SizedBox(width: 4), Text('05:23', style: TextStyle(color: K.white, fontSize: 13, shadows: [Shadow(color: Colors.black45, blurRadius: 8)]))])]),
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), shape: BoxShape.circle), child: const Icon(Icons.chat_rounded, color: K.navy, size: 20)),
      ]))),
      Positioned(top: 100, right: 16, child: Container(width: 100, height: 130, decoration: BoxDecoration(color: const Color(0xFF2A5F7A), borderRadius: BorderRadius.circular(12), border: Border.all(color: K.white, width: 2)), child: Stack(children: [const Center(child: Icon(Icons.person_rounded, size: 60, color: Colors.white54)), Positioned(bottom: 6, right: 6, child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(6)), child: const Icon(Icons.camera_alt_rounded, color: K.white, size: 14)))]))),
      Positioned(bottom: 0, left: 0, right: 0, child: Container(padding: const EdgeInsets.only(top: 20, bottom: 32, left: 24, right: 24), decoration: const BoxDecoration(color: K.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))), child: Column(children: [
        Container(width: 40, height: 4, decoration: BoxDecoration(color: K.grayBorder, borderRadius: BorderRadius.circular(4))),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _cb(Icons.mic_off_rounded, 'Mute', K.grayLight, K.navy, () {}),
          _cb(Icons.call_end_rounded, 'End', K.red, K.white, () => Navigator.pop(context)),
          _cb(Icons.videocam_rounded, 'Camera', K.grayLight, K.navy, () {}),
        ]),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          TextButton.icon(onPressed: () {}, icon: const Icon(Icons.volume_up_rounded, color: K.orange, size: 18), label: const Text('Speaker', style: TextStyle(color: K.orange, fontWeight: FontWeight.w600))),
          TextButton.icon(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded, color: K.gray, size: 18), label: const Text('More', style: TextStyle(color: K.gray))),
        ]),
      ]))),
    ]));
  }
  Widget _cb(IconData icon, String label, Color bg, Color ic, VoidCallback onTap) => GestureDetector(onTap: onTap, child: Column(children: [Container(width: 60, height: 60, decoration: BoxDecoration(shape: BoxShape.circle, color: bg), child: Icon(icon, color: ic, size: 26)), const SizedBox(height: 6), Text(label, style: TextStyle(fontSize: 13, color: label == 'End' ? K.red : K.gray, fontWeight: label == 'End' ? FontWeight.bold : FontWeight.normal))]));
}

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});
  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}
class _RemindersScreenState extends State<RemindersScreen> {
  final List<bool> _chk = [true, true, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: K.grayLight,
      appBar: AppBar(backgroundColor: K.white, elevation: 0.5, leading: IconButton(icon: const Icon(Icons.arrow_back, color: K.navy), onPressed: () => Navigator.pop(context)), title: const Text('Rappels', style: TextStyle(color: K.navy, fontWeight: FontWeight.bold, fontSize: 17)), centerTitle: true, actions: [TextButton.icon(onPressed: () {}, icon: const Icon(Icons.add, color: K.orange, size: 18), label: const Text('Ajouter', style: TextStyle(color: K.orange, fontWeight: FontWeight.w600)))]),
      body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: K.orange, borderRadius: BorderRadius.circular(18)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Progression du jour', style: TextStyle(color: Colors.white70, fontSize: 13)), Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle), child: const Icon(Icons.medication_rounded, color: K.white, size: 22))]),
          const SizedBox(height: 6),
          const Text('2 sur 4', style: TextStyle(color: K.white, fontSize: 32, fontWeight: FontWeight.bold)),
          const Text('medicaments pris aujourd\'hui', style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 14),
          ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: 0.5, backgroundColor: Colors.white.withOpacity(0.25), valueColor: const AlwaysStoppedAnimation<Color>(K.white), minHeight: 10)),
        ])),
        const SizedBox(height: 24),
        const Row(children: [Icon(Icons.calendar_today_rounded, color: K.orange, size: 18), SizedBox(width: 8), Text('Aujourd\'hui', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: K.navy))]),
        const SizedBox(height: 12),
        _med(0, Icons.medication_rounded, K.orange, 'Paracetamol', '500mg - Apres le repas', '08:00'),
        const SizedBox(height: 8),
        _med(1, Icons.vaccines_rounded, K.green, 'Vitamines C', '1 comprime - Avec de l\'eau', '08:30'),
        const SizedBox(height: 8),
        _med(2, Icons.medication_liquid_rounded, K.yellow, 'Amoxicilline', '1g - Apres le repas', '14:00'),
        const SizedBox(height: 8),
        _med(3, Icons.local_pharmacy_rounded, const Color(0xFF7C3AED), 'Ibuprofene', '400mg - Avant de dormir', '20:00'),
        const SizedBox(height: 24),
        const Row(children: [Icon(Icons.wb_sunny_rounded, color: K.gray, size: 18), SizedBox(width: 8), Text('Demain', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: K.navy))]),
        const SizedBox(height: 12),
        _medSimple(Icons.medication_rounded, K.orange, 'Paracetamol', '08:00'),
        const SizedBox(height: 8),
        _medSimple(Icons.vaccines_rounded, K.green, 'Vitamines C', '08:30'),
        const SizedBox(height: 20),
      ])),
      bottomNavigationBar: BottomNavigationBar(selectedItemColor: K.orange, unselectedItemColor: K.gray, currentIndex: 1, type: BottomNavigationBarType.fixed, items: const [BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: ''), BottomNavigationBarItem(icon: Icon(Icons.notifications_rounded), label: ''), BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: ''), BottomNavigationBarItem(icon: Icon(Icons.help_outline_rounded), label: '')]),
    );
  }
  Widget _med(int idx, IconData icon, Color color, String name, String dose, String time) => GestureDetector(onTap: () => setState(() => _chk[idx] = !_chk[idx]), child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), decoration: BoxDecoration(color: K.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: !_chk[idx] ? K.orange.withOpacity(0.3) : K.grayBorder, width: !_chk[idx] ? 2 : 1), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]), child: Row(children: [
    Container(width: 48, height: 48, decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color, size: 24)),
    const SizedBox(width: 14),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: K.navy, fontSize: 15)), const SizedBox(width: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: K.grayLight, borderRadius: BorderRadius.circular(6)), child: Text(time, style: const TextStyle(color: K.gray, fontSize: 11, fontWeight: FontWeight.w600)))]), const SizedBox(height: 3), Text(dose, style: const TextStyle(color: K.gray, fontSize: 12))])),
    Checkbox(value: _chk[idx], onChanged: (v) => setState(() => _chk[idx] = v!), activeColor: K.orange, shape: const CircleBorder()),
  ])));
  Widget _medSimple(IconData icon, Color color, String name, String time) => Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), decoration: BoxDecoration(color: K.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: K.grayBorder)), child: Row(children: [Container(width: 48, height: 48, decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color, size: 24)), const SizedBox(width: 14), Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: K.navy, fontSize: 15))), Text(time, style: const TextStyle(color: K.gray, fontSize: 13))]));
}
