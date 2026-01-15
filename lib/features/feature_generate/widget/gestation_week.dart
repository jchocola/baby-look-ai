import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/features/feature_generate/bloc/prepare_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_popup/flutter_popup.dart';

class GestationWeek extends StatelessWidget {
  const GestationWeek({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gestation Week', style: theme.textTheme.titleMedium),
        Text(
          'Select the current week of pregnancy',
          style: theme.textTheme.bodySmall,
        ),
       

        _weekPicker(),
       
      ],
    );
  }
}

class _weekPicker extends StatelessWidget {
  const _weekPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return CustomPopup(
      content: SizedBox.fromSize(
        size: Size.fromHeight(size.height * 0.4),
        child: SingleChildScrollView(
          child: BlocBuilder<PrepareDataBloc, PrepareDataBlocState>(
            builder: (context, state) => Column(
              children: List.generate(40, (index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstant.appPadding),
                    color:
                        state is PrepareDataBlocState_loaded &&
                            state.gestationWeek == index + 1
                        ? theme.colorScheme.onPrimary
                        : Colors.transparent,
                  ),
                  child: ListTile(
                    title: Text("Week ${index + 1}" ,style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight:  state is PrepareDataBlocState_loaded &&
                            state.gestationWeek == index + 1
                        ? FontWeight.bold
                        :FontWeight.normal
                    ),),
                    onTap: () => context.read<PrepareDataBloc>().add(
                      PrepareDataBlocEvent_setGestationWeek(value: index + 1),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      child: BlocBuilder<PrepareDataBloc, PrepareDataBlocState>(
        builder: (context, state) => ListTile(
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstant.borderRadius),
              border: Border.all(color: theme.colorScheme.secondary)
            ),
            child: ListTile(
              title: Text(
                 state is PrepareDataBlocState_loaded && state.gestationWeek!=null ?  'Week ${ state.gestationWeek}' : 'Please pick gestation week',
                 style: theme.textTheme.titleMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
