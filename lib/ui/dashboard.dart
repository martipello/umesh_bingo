import 'package:flutter/material.dart';
import 'package:umesh_bingo/ui/rounded_button.dart';

import '../dependency_injection_container.dart';
import '../view_models/bingo_view_model.dart';
import 'bingo_grid.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final bingoViewModel = getIt.get<BingoViewModel>();

  @override
  void dispose() {
    bingoViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Umesh Bingo'),
      ),
      body: StreamBuilder<bool>(
        stream: bingoViewModel.bingoStream,
        builder: (context, isBingoStream) {
          final isBingo = isBingoStream.data ?? false;
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _buildWelcomeTitle(),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(
                      8.0,
                    ),
                    sliver: BingoGrid(
                      bingoViewModel: bingoViewModel,
                    ),
                  ),
                ],
              ),
              if (isBingo) _buildBingo(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWelcomeTitle() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'WELCOME',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _buildBingo() {
    return Container(
      color: Colors.white.withOpacity(0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/umesh_bingo.png',
            height: 250,
            fit: BoxFit.fill,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                'UMESH BINGO',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Icon(
                Icons.star,
                color: Colors.yellow,
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          RoundedButton(
            label: 'RETRY',
            isFilled: true,
            onPressed: () {
              bingoViewModel.reset();
            },
          )
        ],
      ),
    );
  }
}
