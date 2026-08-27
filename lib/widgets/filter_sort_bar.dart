import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:certification_ecommerce_riverpod/data/models/models.dart';
import 'package:certification_ecommerce_riverpod/providers/providers.dart';

class FilterSortBar extends ConsumerWidget {
  const FilterSortBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(filterSortProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          OutlinedButton.icon(
            onPressed: () => _showFilterDialog(context, ref),
            icon: const Icon(Icons.filter_list_alt),
            label: Text(filterState.selectedCategory ?? 'Filtrer'),
          ),
          const SizedBox(width: 8),
          DropdownButton<SortOption>(
            value: filterState.sortOption,
            items: const [
              DropdownMenuItem(value: SortOption.relevance, child: Text(' Pertinence')),
              DropdownMenuItem(value: SortOption.priceAsc, child: Text('Prix croissant')),
              DropdownMenuItem(value: SortOption.priceDesc, child: Text('Prix decroissant')),
              DropdownMenuItem(value: SortOption.rating, child: Text('Notes')),
            ],
            onChanged: (value) {
              if (value != null) {
                ref.read(filterSortProvider.notifier).setSortOption(value);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context, WidgetRef ref) {
    final categories = ['Electronique', 'Mode', 'Accessoires', 'Maison'];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrer et trier'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Categorie'),
              initialValue: ref.read(filterSortProvider).selectedCategory,
              items: [
                const DropdownMenuItem(value: null, child: Text('Toutes')),
                ...categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
              ],
              onChanged: (value) =>
                  ref.read(filterSortProvider.notifier).setCategory(value),
            ),
            DropdownButtonFormField<SortOption>(
              decoration: const InputDecoration(labelText: 'Trier par'),
              initialValue: ref.read(filterSortProvider).sortOption,
              items: const [
                DropdownMenuItem(value: SortOption.relevance, child: Text('Pertinence')),
                DropdownMenuItem(value: SortOption.priceAsc, child: Text('Prix croissant')),
                DropdownMenuItem(value: SortOption.priceDesc, child: Text('Prix decroissant')),
                DropdownMenuItem(value: SortOption.rating, child: Text('Notes')),
              ],
              onChanged: (value) {
                if (value != null) {
                  ref.read(filterSortProvider.notifier).setSortOption(value);
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(filterSortProvider.notifier).reset();
              Navigator.pop(context);
            },
            child: const Text('Reinitialiser'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }
}
