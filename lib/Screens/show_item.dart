import 'package:cake/models/item.dart';
import 'package:cake/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShowItem extends StatefulWidget {
  const ShowItem({super.key, required this.item});

  final Item item;

  @override
  State<ShowItem> createState() => _ShowItemState();
}

class _ShowItemState extends State<ShowItem> {
  int _quantity = 1;
  bool _isFavorite = false;

  double get _totalPrice => widget.item.price * _quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(child: _buildMainContent()),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            widget.item.imagePath,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey[900],
              child: const Center(
                child: Icon(Icons.restaurant, size: 100, color: Colors.white24),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.4),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.9),
                ],
                stops: const [0.0, 0.3, 1.0],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [_buildTopBar(), const Spacer(), _buildContent()],
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleBtn(
            Icons.arrow_back_ios_new,
            () => Navigator.pop(context),
          ),
          Row(
            children: [
              _buildCircleBtn(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                () => setState(() => _isFavorite = !_isFavorite),
                color: _isFavorite ? Colors.red : Colors.white,
              ),
              const SizedBox(width: 8),
              _buildCircleBtn(Icons.share, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleBtn(
    IconData icon,
    VoidCallback onTap, {
    Color color = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.item.category,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.item.name,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.item.rating.toString(),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '(${widget.item.reviewCount} reviews)',
                style: GoogleFonts.poppins(color: Colors.white60, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.item.description,
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildQuantitySelector(),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Total',
                    style: GoogleFonts.poppins(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '\$${_totalPrice.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _buildQtyBtn(Icons.remove, () {
            if (_quantity > 1) setState(() => _quantity--);
          }),
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text(
              '$_quantity',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildQtyBtn(Icons.add, () => setState(() => _quantity++)),
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: GestureDetector(
          onTap: _addToCart,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withValues(alpha: 0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_cart, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  'Add to Cart',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addToCart() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    for (int i = 0; i < _quantity; i++) {
      cart.addItem(widget.item);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(child: Text('$_quantity x ${widget.item.name} added!')),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
    Navigator.pop(context);
  }
}
