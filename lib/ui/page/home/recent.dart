import 'package:flutter/material.dart';
import 'package:piggy_flutter/bloc/transaction_bloc.dart';
import 'package:piggy_flutter/model/transaction_group_item.dart';
import 'package:piggy_flutter/providers/transaction_provider.dart';
import 'package:piggy_flutter/ui/page/transaction/transaction_form.dart';
import 'package:piggy_flutter/ui/widgets/transaction_list.dart';

class RecentPage extends StatelessWidget {
  RecentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('########## RecentPage build');
    final TransactionBloc transactionBloc = TransactionProvider.of(context);

    return Scaffold(
      body: transactionListBuilder(transactionBloc),
      floatingActionButton: new FloatingActionButton(
          key: new ValueKey<Color>(Theme.of(context).primaryColor),
          tooltip: 'Add new transaction',
          backgroundColor: Theme.of(context).primaryColor,
          child: new Icon(Icons.add_circle_outline),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute<DismissDialogAction>(
                  builder: (BuildContext context) => new TransactionFormPage(),
                  fullscreenDialog: true,
                ));
          }),
    );
  }

  Widget transactionListBuilder(TransactionBloc transactionBloc) =>
      StreamBuilder<List<TransactionGroupItem>>(
        stream: transactionBloc.recentTransactions,
        builder: (context, snapshot) => TransactionList(
            transactions: snapshot.hasData ? snapshot.data : null),
      );
}
