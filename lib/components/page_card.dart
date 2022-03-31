import 'package:flutter/material.dart';

abstract class PageCard extends StatelessWidget {
  final VoidCallback? nextPage;
  const PageCard({Key? key, this.nextPage}) : super(key: key);
}
