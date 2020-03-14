import 'dart:ui';

import 'package:flutter/cupertino.dart';
const Duration _kModalPopupTransitionDuration = Duration(milliseconds: 335);
const Color _kModalBarrierColor = CupertinoDynamicColor.withBrightness(
  color: Color(0x33000000),
  darkColor: Color(0x7A000000),
);

class _CupertinoModalPopupRoute<T> extends PopupRoute<T> {
  _CupertinoModalPopupRoute({
    this.barrierColor,
    this.barrierLabel,
    this.builder,
    ImageFilter filter,
    RouteSettings settings,
  }) : super(
    filter: filter,
    settings: settings,
  );

  final WidgetBuilder builder;

  @override
  final String barrierLabel;

  @override
  final Color barrierColor;

  @override
  bool get barrierDismissible => true;

  @override
  bool get semanticsDismissible => false;

  @override
  Duration get transitionDuration => _kModalPopupTransitionDuration;

  Animation<double> _animation;

  Tween<Offset> _offsetTween;

  @override
  Animation<double> createAnimation() {
    assert(_animation == null);
    _animation = CurvedAnimation(
      parent: super.createAnimation(),

      // These curves were initially measured from native iOS horizontal page
      // route animations and seemed to be a good match here as well.
      curve: Curves.easeInOutExpo,
      reverseCurve: Curves.easeInOutExpo,

    );
    _offsetTween = Tween<Offset>(
      begin: const Offset(0.0, 50),
      end: const Offset(0.0, 0,)
    );
    return _animation;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return CupertinoUserInterfaceLevel(
      data: CupertinoUserInterfaceLevelData.elevated,
      child: Builder(builder: builder),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return Align(
      alignment: Alignment(0, 0.85),
      child: FractionalTranslation(
        translation: _offsetTween.evaluate(_animation),
        child: child,
      ),
    );
  }
}

/// Shows a modal iOS-style popup that slides up from the bottom of the screen.
///
/// Such a popup is an alternative to a menu or a dialog and prevents the user
/// from interacting with the rest of the app.
///
/// The `context` argument is used to look up the [Navigator] for the popup.
/// It is only used when the method is called. Its corresponding widget can be
/// safely removed from the tree before the popup is closed.
///
/// The `useRootNavigator` argument is used to determine whether to push the
/// popup to the [Navigator] furthest from or nearest to the given `context`. It
/// is `false` by default.
///
/// The `builder` argument typically builds a [CupertinoActionSheet] widget.
/// Content below the widget is dimmed with a [ModalBarrier]. The widget built
/// by the `builder` does not share a context with the location that
/// `showCupertinoModalPopup` is originally called from. Use a
/// [StatefulBuilder] or a custom [StatefulWidget] if the widget needs to
/// update dynamically.
///
/// Returns a `Future` that resolves to the value that was passed to
/// [Navigator.pop] when the popup was closed.
///
/// See also:
///
///  * [ActionSheet], which is the widget usually returned by the `builder`
///    argument to [showCupertinoModalPopup].
///  * <https://developer.apple.com/design/human-interface-guidelines/ios/views/action-sheets/>
Future<T> showMyCupertinoModalPopup<T>({
  @required BuildContext context,
  @required WidgetBuilder builder,
  ImageFilter filter,
  bool useRootNavigator = true,
}) {
  assert(useRootNavigator != null);
  return Navigator.of(context, rootNavigator: useRootNavigator).push(
    _CupertinoModalPopupRoute<T>(
      barrierColor: CupertinoDynamicColor.resolve(_kModalBarrierColor, context),
      barrierLabel: 'Dismiss',
      builder: builder,
      filter: filter,
    ),
  );
}