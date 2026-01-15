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
        Row(
          spacing: AppConstant.appPadding,
          children: [
            Text('Selected:', style: theme.textTheme.bodySmall),
            BlocBuilder<PrepareDataBloc,PrepareDataBlocState>(builder:(context,state)=> Text('Week ${state is PrepareDataBlocState_loaded ? state.gestationWeek : 0}', style: theme.textTheme.titleSmall)),
          ],
        ),
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
          child: BlocBuilder<PrepareDataBloc,PrepareDataBlocState>(
            builder: (context,state)=> Column(
              children: List.generate(40, (index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstant.appPadding),
                    color:  state is PrepareDataBlocState_loaded && state.gestationWeek == index+1 ? theme.colorScheme.primary : Colors.transparent
                  ),
                  child: ListTile(title: Text("Week ${index + 1}" ), onTap: () => context.read<PrepareDataBloc>().add(PrepareDataBlocEvent_setGestationWeek(value: index+1)),));
              }),
            ),
          ),
        ),
      ),
      child: BlocBuilder<PrepareDataBloc,PrepareDataBlocState>(builder:(context,state)=> ListTile(title: Text('Week ${state is PrepareDataBlocState_loaded ? state.gestationWeek : 0}'))),
    );
  }
}
