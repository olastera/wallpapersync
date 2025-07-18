import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FrequencyPickerWidget extends StatefulWidget {
  final String currentFrequency;
  final Function(String) onFrequencyChanged;

  const FrequencyPickerWidget({
    Key? key,
    required this.currentFrequency,
    required this.onFrequencyChanged,
  }) : super(key: key);

  @override
  State<FrequencyPickerWidget> createState() => _FrequencyPickerWidgetState();
}

class _FrequencyPickerWidgetState extends State<FrequencyPickerWidget> {
  late String _selectedFrequency;
  TimeOfDay _customTime = TimeOfDay(hour: 9, minute: 0);
  int _customHours = 6;

  @override
  void initState() {
    super.initState();
    _selectedFrequency = widget.currentFrequency;
  }

  @override
  Widget build(BuildContext context) {
    final frequencies = [
      {
        'value': 'hourly',
        'title': 'Cada Hora',
        'subtitle': 'Cambiar fondo cada hora',
        'icon': 'schedule'
      },
      {
        'value': 'daily',
        'title': 'Diariamente',
        'subtitle': 'Cambiar fondo una vez al día',
        'icon': 'today'
      },
      {
        'value': 'weekly',
        'title': 'Semanalmente',
        'subtitle': 'Cambiar fondo una vez por semana',
        'icon': 'date_range'
      },
      {
        'value': 'custom',
        'title': 'Personalizado',
        'subtitle': 'Configurar intervalo personalizado',
        'icon': 'tune'
      },
    ];

    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'schedule',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              SizedBox(width: 3.w),
              Text(
                'Frecuencia de Actualización',
                style: AppTheme.lightTheme.textTheme.titleLarge,
              ),
            ],
          ),
          SizedBox(height: 2.h),
          ...frequencies.map((frequency) => Container(
                margin: EdgeInsets.only(bottom: 1.h),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: BoxDecoration(
                          color: _selectedFrequency == frequency['value']
                              ? AppTheme.lightTheme.colorScheme.primaryContainer
                              : AppTheme.lightTheme.colorScheme
                                  .surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(3.w),
                        ),
                        child: Center(
                          child: CustomIconWidget(
                            iconName: frequency['icon'] as String,
                            color: _selectedFrequency == frequency['value']
                                ? AppTheme.lightTheme.colorScheme.primary
                                : AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                        ),
                      ),
                      title: Text(
                        frequency['title'] as String,
                        style: AppTheme.lightTheme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        frequency['subtitle'] as String,
                        style: AppTheme.lightTheme.textTheme.bodySmall,
                      ),
                      trailing: _selectedFrequency == frequency['value']
                          ? CustomIconWidget(
                              iconName: 'check_circle',
                              color: AppTheme.lightTheme.colorScheme.primary,
                              size: 24,
                            )
                          : CustomIconWidget(
                              iconName: 'radio_button_unchecked',
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                              size: 24,
                            ),
                      onTap: () {
                        setState(() {
                          _selectedFrequency = frequency['value'] as String;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                    ),
                    _selectedFrequency == 'custom' &&
                            frequency['value'] == 'custom'
                        ? _buildCustomFrequencyOptions()
                        : SizedBox.shrink(),
                  ],
                ),
              )),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar'),
              ),
              SizedBox(width: 2.w),
              ElevatedButton(
                onPressed: () {
                  widget.onFrequencyChanged(_selectedFrequency);
                  Navigator.pop(context);
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomFrequencyOptions() {
    return Container(
      margin: EdgeInsets.only(left: 16.w, right: 4.w, top: 1.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surfaceContainerHighest
            .withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Configuración Personalizada',
            style: AppTheme.lightTheme.textTheme.titleSmall,
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Text(
                'Cada',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
              SizedBox(width: 2.w),
              Container(
                width: 20.w,
                child: DropdownButtonFormField<int>(
                  value: _customHours,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                  ),
                  items: List.generate(24, (index) => index + 1)
                      .map((hour) => DropdownMenuItem(
                            value: hour,
                            child: Text('$hour'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _customHours = value ?? 6;
                    });
                  },
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                _customHours == 1 ? 'hora' : 'horas',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Text(
                'Comenzar a las:',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
              SizedBox(width: 2.w),
              TextButton(
                onPressed: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: _customTime,
                  );
                  if (picked != null) {
                    setState(() {
                      _customTime = picked;
                    });
                  }
                },
                child: Text(
                  '${_customTime.format(context)}',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
