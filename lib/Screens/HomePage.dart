import 'package:cake/data/items.dart';
import 'package:cake/models/item.dart';
import 'package:cake/providers/cart_provider.dart';
import 'package:cake/Screens/cart_screen.dart';
import 'package:cake/Screens/show_item.dart';
import 'package:cake/widgets/item_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FantasyHomepage extends StatefulWidget {
  const FantasyHomepage({super.key});

  @override
  State<FantasyHomepage> createState() => _FantasyHomepageState();
}

class _FantasyHomepageState extends State<FantasyHomepage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFFAFAFA)),
        child: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildAppBar(),
              _buildSearchBar(),
              _buildHeroBanner(),
              _buildCategoriesRow(),
              _buildBigPost(),
              _buildTwoItemsRow(),
              _buildOfferBanner(),
              _buildBestCakes(),
              _buildDrinksSection(),
              _buildHorizontalScroll(),
              _buildStaggeredGrid(),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildCartBtn(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.cake_rounded, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Text('Cake Shop', style: GoogleFonts.righteous(fontSize: 24, color: Colors.black)),
        ],
      ),
      actions: [
        IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.black), onPressed: () {}),
        Consumer<CartProvider>(
          builder: (ctx, cart, _) => Stack(
            children: [
              IconButton(icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()))),
              if (cart.itemCount > 0)
                Positioned(right: 6, top: 6, child: Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: Text('${cart.itemCount}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () => showSearch(context: context, delegate: ItemSearchDelegate()),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey[600]),
                const SizedBox(width: 12),
                Text('Search cakes, drinks...', style: GoogleFonts.poppins(color: Colors.grey[600])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 160,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF667eea), Color(0xFF764ba2)]),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Get 50% OFF', style: GoogleFonts.righteous(fontSize: 26, color: Colors.white)),
                  const SizedBox(height: 8),
                  Text('On all premium cakes\nFirst order only!', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: Text('Order Now', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: const Color(0xFF667eea))),
                  ),
                ],
              ),
            ),
            const Icon(Icons.cake_rounded, size: 80, color: Colors.white24),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesRow() {
    final cats = [
      {'icon': Icons.cake_rounded, 'label': 'Cakes', 'color': Colors.pink},
      {'icon': Icons.local_drink_rounded, 'label': 'Drinks', 'color': Colors.blue},
      {'icon': Icons.icecream_rounded, 'label': 'Ice Cream', 'color': Colors.purple},
      {'icon': Icons.cookie_rounded, 'label': 'Cookies', 'color': Colors.orange},
    ];
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: cats.map((c) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: (c['color'] as Color).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16)),
                  child: Icon(c['icon'] as IconData, color: c['color'] as Color, size: 28),
                ),
                const SizedBox(height: 8),
                Text(c['label'] as String, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBigPost() {
    final item = dummyItems.first;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShowItem(item: item))),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(image: AssetImage(item.imagePath), fit: BoxFit.cover),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)]),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(8)),
                    child: Text('FEATURED', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  const SizedBox(height: 8),
                  Text(item.name, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('\$${item.price.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontSize: 18, color: Colors.white70)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTwoItemsRow() {
    final items = dummyItems.where((i) => i.isFeatured).take(2).toList();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: items.map((item) {
            return Expanded(
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShowItem(item: item))),
                child: Container(
                  height: 180,
                  margin: EdgeInsets.only(right: items.indexOf(item) == 0 ? 10 : 0, left: items.indexOf(item) == 0 ? 0 : 10),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 20, offset: const 10))]),
                  child: Column Offset(0,(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                          child: Image.asset(item.imagePath, width: double.infinity, fit: BoxFit.cover),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 4),
                            Text('\$${item.price.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.pink)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildOfferBanner() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF11998e), Color(0xFF38ef7d)]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Limited Offer!', style: GoogleFonts.righteous(fontSize: 20, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text('Buy 1 Get 1 Free on all smoothies', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.local_drink_rounded, color: Color(0xFF11998e), size: 30),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBestCakes() {
    final cakes = dummyItems.where((i) => i.type == 'cake').take(5).toList();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('🏆 Best Cakes', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('See All', style: GoogleFonts.poppins(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cakes.length,
                itemBuilder: (ctx, i) => _buildSmallCard(cakes[i], i),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrinksSection() {
    final drinks = dummyItems.where((i) => i.type == 'drinks').take(4).toList();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🥤 Fresh Drinks', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: drinks.map((item) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShowItem(item: item))),
                    child: Container(
                      height: 140,
                      margin: EdgeInsets.only(right: drinks.indexOf(item) < drinks.length - 1 ? 10 : 0),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 15, offset: const Offset(0, 6))]),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: Image.asset(item.imagePath, width: double.infinity, fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Text(item.name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
                                Text('\$${item.price.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.blue)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalScroll() {
    final items = dummyItems.where((i) => i.isNew).toList();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🆕 New Arrivals', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (ctx, i) => Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.asset(items[i].imagePath, width: double.infinity, fit: BoxFit.cover),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('\$${items[i].price.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallCard(Item item, int index) {
    final colors = [Colors.pink, Colors.blue, Colors.orange, Colors.green, Colors.purple];
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShowItem(item: item))),
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: colors[index % colors.length].withValues(alpha: 0.2), blurRadius: 15, offset: const Offset(0, 6))]),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(item.imagePath, width: double.infinity, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(item.name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${item.price.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: colors[index % colors.length], fontSize: 12)),
                      const Icon(Icons.add_circle, size: 18, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaggeredGrid() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('✨ Explore More', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildStaggeredItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildStaggeredItems() {
    final items = dummyItems;
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isBig = index % 3 == 0;
        final colors = [Colors.pink, Colors.blue, Colors.orange, Colors.green, Colors.purple, Colors.teal];
        final color = colors[index % colors.length];

        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShowItem(item: item))),
          child: Container(
            width: (MediaQuery.of(context).size.width - 52) / (isBig ? 1 : 2),
            height: isBig ? 220 : 180,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 15, offset: const Offset(0, 6))]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.asset(item.imagePath, width: double.infinity, fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  flex: isBig ? 1 : 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: isBig ? 14 : 12), maxLines: isBig ? 2 : 1, overflow: TextOverflow.ellipsis),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('\$${item.price.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: color, fontSize: isBig ? 16 : 14)),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
                              child: const Icon(Icons.add, color: Colors.white, size: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCartBtn() {
    return Consumer<CartProvider>(
      builder: (ctx, cart, _) {
        if (cart.itemCount == 0) return const SizedBox.shrink();
        return FloatingActionButton.extended(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
          backgroundColor: Colors.black,
          icon: const Icon(Icons.shopping_cart, color: Colors.white),
          label: Text('\$${cart.totalPrice.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
        );
      },
    );
  }
}
