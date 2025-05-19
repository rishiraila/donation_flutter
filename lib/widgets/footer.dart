import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 800;

    return Container(
      color: const Color(0xFFFDF4F4),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child:
          isWide
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection('About Us', [
                    'About Give',
                    'Blog',
                    'Careers',
                    'Contact us',
                  ], isWide),
                  _buildSection('Fundraiser Support', [
                    'FAQs',
                    'Reach out',
                  ], isWide),
                  _buildSection('Start a Fundraiser for', ['NGO'], isWide),
                  _buildSection('Donate to', ['Social Causes', 'NGOs'], isWide),
                  const Spacer(),
                  _buildCurrencyAndSocial(isWide: true),
                ],
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection('About Us', [
                    'About Give',
                    'Blog',
                    'Careers',
                    'Contact us',
                  ], isWide),
                  const SizedBox(height: 16),
                  _buildSection('Fundraiser Support', [
                    'FAQs',
                    'Reach out',
                  ], isWide),
                  const SizedBox(height: 16),
                  _buildSection('Start a Fundraiser for', ['NGO'], isWide),
                  const SizedBox(height: 16),
                  _buildSection('Donate to', ['Social Causes', 'NGOs'], isWide),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _buildCurrencyAndSocial(isWide: false),
                  ),
                ],
              ),
    );
  }

  Widget _buildSection(String title, List<String> items, bool isWide) {
    final sectionContent = Padding(
      padding: const EdgeInsets.only(right: 24.0, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                item,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );

    // Only wrap with Expanded on wide screens where it's inside a Row
    return isWide ? Expanded(child: sectionContent) : sectionContent;
  }

  Widget _buildCurrencyAndSocial({required bool isWide}) {
    return Padding(
      padding: isWide ? EdgeInsets.zero : const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment:
            isWide ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Currency selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('INR(₹)', style: TextStyle(fontWeight: FontWeight.w600)),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Social media icons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(FontAwesomeIcons.facebookF, size: 18),
              SizedBox(width: 16),
              Icon(FontAwesomeIcons.twitter, size: 18),
              SizedBox(width: 16),
              Icon(FontAwesomeIcons.instagram, size: 18),
              SizedBox(width: 16),
              Icon(FontAwesomeIcons.linkedinIn, size: 18),
              SizedBox(width: 16),
              Icon(FontAwesomeIcons.youtube, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}
