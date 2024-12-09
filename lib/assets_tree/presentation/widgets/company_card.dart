import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_test/assets_tree/data/models/company_model.dart';
import 'package:tractian_test/core/utils/svg_icons.dart';

class CompanyCard extends StatelessWidget {
  final CompanyModel company;
  final void Function(String id) onTap;

  const CompanyCard({
    super.key,
    required this.company,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        onTap(company.id);
      },
      child: Container(
        height: 76,
        decoration: BoxDecoration(
          color: const Color(0xFF2188FF),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Row(
            children: [
              SvgPicture.asset(SvgIcons.company),
              const SizedBox(width: 15),
              Text(
                company.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
