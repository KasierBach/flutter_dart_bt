import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

part 'exercise_pages_01_10.dart';
part 'exercise_pages_11_20.dart';

typedef _Calculator = String Function(String input);
typedef _StaticCalculator = String Function();

class _LabPage extends StatelessWidget {
  const _LabPage({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    );
  }
}

class _LabSection extends StatelessWidget {
  const _LabSection({
    required this.title,
    required this.child,
    this.description,
  });

  final String title;
  final String? description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          if (description != null) ...<Widget>[
            const SizedBox(height: 6),
            Text(
              description!,
              style: const TextStyle(color: Color(0xFF8792A1), height: 1.45),
            ),
          ],
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _ResultPanel extends StatelessWidget {
  const _ResultPanel({
    required this.value,
    this.error = false,
    this.emptyMessage = 'Chưa có kết quả. Hãy nhập dữ liệu và nhấn Chạy.',
  });

  final String? value;
  final bool error;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    final bool hasValue = value != null && value!.isNotEmpty;
    final Color foreground = error
        ? const Color(0xFFFF8A80)
        : hasValue
        ? const Color(0xFFDCE3EA)
        : const Color(0xFF687384);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 112),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: error ? const Color(0xFF211416) : const Color(0xFF111820),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: error ? const Color(0xFF613238) : const Color(0xFF29323D),
        ),
      ),
      child: SelectableText(
        hasValue ? value! : emptyMessage,
        style: TextStyle(
          color: foreground,
          height: 1.55,
          fontFamily: 'monospace',
          fontSize: 13.5,
        ),
      ),
    );
  }
}

class _SingleInputRunner extends StatefulWidget {
  const _SingleInputRunner({
    required this.label,
    required this.hint,
    required this.initialValue,
    required this.calculate,
    this.maxLines = 1,
    this.keyboardType,
    this.actionLabel = 'Chạy bài',
  });

  final String label;
  final String hint;
  final String initialValue;
  final _Calculator calculate;
  final int maxLines;
  final TextInputType? keyboardType;
  final String actionLabel;

  @override
  State<_SingleInputRunner> createState() => _SingleInputRunnerState();
}

class _SingleInputRunnerState extends State<_SingleInputRunner> {
  late final TextEditingController controller;
  String? result;
  bool error = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void run() {
    try {
      final String output = widget.calculate(controller.text);
      setState(() {
        result = output;
        error = false;
      });
    } catch (exception) {
      setState(() {
        result = exception.toString().replaceFirst('FormatException: ', '');
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _LabPage(
      children: <Widget>[
        _LabSection(
          title: 'Dữ liệu đầu vào',
          child: TextField(
            key: const Key('single-input'),
            controller: controller,
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            onSubmitted: (_) => run(),
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hint,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: FilledButton.icon(
            key: const Key('run-exercise'),
            onPressed: run,
            icon: const Icon(Icons.play_arrow_rounded),
            label: Text(widget.actionLabel),
          ),
        ),
        const SizedBox(height: 28),
        _LabSection(
          title: 'Kết quả',
          child: _ResultPanel(value: result, error: error),
        ),
      ],
    );
  }
}

class _StaticRunner extends StatefulWidget {
  const _StaticRunner({
    required this.buttonLabel,
    required this.calculate,
    this.description,
  });

  final String buttonLabel;
  final _StaticCalculator calculate;
  final String? description;

  @override
  State<_StaticRunner> createState() => _StaticRunnerState();
}

class _StaticRunnerState extends State<_StaticRunner> {
  String? result;

  @override
  Widget build(BuildContext context) {
    return _LabPage(
      children: <Widget>[
        _LabSection(
          title: 'Thực thi',
          description: widget.description,
          child: Align(
            alignment: Alignment.centerLeft,
            child: FilledButton.icon(
              onPressed: () => setState(() => result = widget.calculate()),
              icon: const Icon(Icons.play_arrow_rounded),
              label: Text(widget.buttonLabel),
            ),
          ),
        ),
        _LabSection(
          title: 'Kết quả',
          child: _ResultPanel(value: result),
        ),
      ],
    );
  }
}

class _InlineActions extends StatelessWidget {
  const _InlineActions({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 10, runSpacing: 10, children: children);
  }
}

List<int> _parseIntegerList(String input) {
  final String normalized = input.trim();
  if (normalized.isEmpty) {
    throw const FormatException('Danh sách không được để trống.');
  }

  final List<int> values = <int>[];
  for (final String part in normalized.split(RegExp(r'[\s,]+'))) {
    final int? value = int.tryParse(part);
    if (value == null) {
      throw FormatException('"$part" không phải số nguyên.');
    }
    values.add(value);
  }
  return values;
}

InputDecoration _compactInput(String label, {String? hint}) {
  return InputDecoration(labelText: label, hintText: hint);
}
