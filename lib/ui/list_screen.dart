import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/provider/cart_provider.dart';
import 'package:riverpod_tutorial/ui/cart_item.dart';
import 'package:riverpod_tutorial/provider/menu_provider.dart';

class ListScreen extends ConsumerWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<CartItem> cartItems = ref.watch(filteredCartListProvider);
    int totalItems = ref.read(cartListProvider.notifier).countTotalItems();
    String dropDownValue = ref.watch(menuProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Lista del super',
          style: TextStyle(
            color: Color(0xFF222B45),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                style: const TextStyle(color: Color(0xFF222B45)),
                icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF222B45)),
                value: dropDownValue,
                items: menuItems
                    .map((String e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (String? value) => ref
                    .read(menuProvider.notifier)
                    .update((state) => state = value!),
              ),
            ),
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text(
                    'No hay productos en la lista',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: item.inCart ? Colors.green[50] : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: item.inCart ? Colors.green : Colors.blue,
                        child: Icon(
                          item.inCart ? Icons.check : Icons.shopping_bag_outlined,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        'Item de compra ${item.number}',
                        style: TextStyle(
                          decoration: item.inCart ? TextDecoration.lineThrough : null,
                          color: item.inCart ? Colors.green : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Switch(
                        value: item.inCart,
                        activeColor: Colors.green,
                        onChanged: (value) => ref
                            .read(cartListProvider.notifier)
                            .toggle(item.number),
                      ),
                      onTap: () => ref
                          .read(cartListProvider.notifier)
                          .toggle(item.number),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemCount: cartItems.length,
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue[700],
        icon: const Icon(Icons.add),
        label: const Text('Agregar'),
        onPressed: () => ref
            .read(cartListProvider.notifier)
            .add(CartItem(number: totalItems, inCart: false)),
      ),
    );
  }
}
