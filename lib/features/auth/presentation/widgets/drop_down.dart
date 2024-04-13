import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/style.dart';

class ProfileDropDown extends StatefulWidget {
  final List<String> items;
  final String val;
  final String hintText;
  final Function(String?) onChanged;
  const ProfileDropDown({
    super.key,
    required this.items,
    required this.val,
    required this.hintText,
    required this.onChanged,
  });

  @override
  State<ProfileDropDown> createState() => _ProfileDropDownState();
}

class _ProfileDropDownState extends State<ProfileDropDown> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      onChanged: widget.onChanged,
      dropdownSearchData: DropdownSearchData(
        searchController: textEditingController,
        searchInnerWidgetHeight: 50,
        searchInnerWidget: Container(
          height: 50,
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 4,
            right: 8,
            left: 8,
          ),
          child: TextFormField(
            expands: true,
            maxLines: null,
            controller: textEditingController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              hintText: 'Search for an item...',
              hintStyle: const TextStyle(fontSize: 12, color: otherGrey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        // searchMatchFn: (item, searchValue) {
        //   return item.value
        //       .toString()
        //       .toLowerCase()
        //       .contains(searchValue.toLowerCase());
        // },
      ),
      hint: Text(
        widget.hintText,
        style: textStyle14.copyWith(color: otherGrey),
      ),
      value: widget.val.isNotEmpty ? widget.val : null,
      validator: (value) => value == null ? 'Field required' : null,
      isDense: true,
      style: textStyle14,
      items: widget.items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(
            value,
            overflow: TextOverflow.clip,
            style: textStyle14.copyWith(
              color: black,
            ),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: red, width: 1.5),
        ),
        hintText: 'Choose reason',
        isDense: true,
        hintStyle: textStyle14.copyWith(
          color: otherGrey,
          fontSize: 14.sp,
        ),
        contentPadding: EdgeInsets.only(
          right: 10,
          top: 10.sp,
          bottom: 10.sp,
        ),
        filled: true,
        fillColor: white,
        border: outlineInputBorder.copyWith(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: textBorderColor,
          ),
        ),
        enabledBorder: outlineInputBorder.copyWith(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: textBorderColor,
          ),
        ),
        focusedBorder: outlineInputBorder.copyWith(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: textBorderColor,
          ),
        ),
      ),
    );
  }
}
