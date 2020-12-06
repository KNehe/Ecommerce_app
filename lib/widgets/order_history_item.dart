import 'package:ecommerceapp/constants/tasks.dart';
import 'package:ecommerceapp/controllers/activity_tracker_controller.dart';
import 'package:ecommerceapp/controllers/order_controller.dart';
import 'package:ecommerceapp/models/order.dart';
import 'package:ecommerceapp/screens/single_order.dart';
import 'package:ecommerceapp/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderHistoryItem extends StatelessWidget {
  final Order order;
  const OrderHistoryItem({
    Key key,
    @required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(Icons.info),
        trailing: Icon(Icons.info_outlined),
        title: Text(
          'Order ${order.id}',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          'Made on ${DateUtils().getFormattedDate(order.dateOrdered.toString())}',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        tileColor: Colors.grey[200],
        contentPadding: EdgeInsets.all(10.0),
        onTap: () {
          Provider.of<ActivityTracker>(context, listen: false)
              .setTaskCurrentTask(VIEWING_SINGLE_OLD_ORDER_HISTORY);

          Provider.of<OrderController>(context, listen: false)
              .setSingleOrder(order);

          Navigator.pushNamed(context, SingleOrder.id);
        },
      ),
    );
  }
}
