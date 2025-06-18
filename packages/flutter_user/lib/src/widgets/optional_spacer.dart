import "package:flutter/material.dart";

/// Helper function to conditionally add a Spacer.
///
/// If [flex] is not null, a [Spacer] with the given flex value is returned.
/// Otherwise, an empty list is returned, effectively adding nothing to the
/// widget tree.
List<Widget> buildOptionalSpacer(int? flex) {
  if (flex != null) {
    return [
      Spacer(
        flex: flex,
      ),
    ];
  }
  return [];
}
