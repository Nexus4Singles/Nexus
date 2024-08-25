import 'package:flutter/material.dart';
import 'package:glassfy_flutter/models.dart';
import 'package:Nexus/core/colors.dart';
import 'package:provider/provider.dart';
import '../provider/subscription_provider.dart';

class PayWallWidget extends StatefulWidget {
  const PayWallWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.offer,
    required this.onClickedSku,
  }) : super(key: key);

  final String title;
  final String description;
  final GlassfyOffering offer;
  final ValueChanged<GlassfySku> onClickedSku;

  @override
  State<PayWallWidget> createState() => _PayWallWidgetState();
}

class _PayWallWidgetState extends State<PayWallWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionProvider>(
      builder: (context, subProvider, child) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.3,
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: primary),
                        const SizedBox(width: 8),
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: widget.offer.skus?.length,
                      itemBuilder: (context, index) {
                        final sku = widget.offer.skus![index];
                        return Card(
                          color: primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8),
                            title: Text(
                              '${widget.offer.offeringId}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${sku.product?.description}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            trailing: Text(
                              '${sku.product?.price}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              widget.onClickedSku(sku);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              if (subProvider.isLoading)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }
}
