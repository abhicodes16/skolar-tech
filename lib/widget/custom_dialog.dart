import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

class Dialog extends StatelessWidget {
  const Dialog({
    Key? key,
    this.child,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
  }) : super(key: key);

  final Widget? child;

  final Duration insetAnimationDuration;

  final Curve insetAnimationCurve;

  Color _getColor(BuildContext context) {
    return Theme.of(context).dialogBackgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 280.0),
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              elevation: 30.0,
              color: _getColor(context),
              type: MaterialType.card,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  /// Creates an alert dialog.
  ///
  /// Typically used in conjunction with [showDialog].
  ///
  /// The [contentPadding] must not be null. The [titlePadding] defaults to
  /// null, which implies a default that depends on the values of the other
  /// properties. See the documentation of [titlePadding] for details.
  const CustomAlertDialog({
    Key? key,
    this.title,
    this.titlePadding,
    this.content,
    this.contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.semanticLabel,
  })  : assert(contentPadding != null),
        super(key: key);

  final Widget? title;

  final EdgeInsetsGeometry? titlePadding;

  final Widget? content;

  final EdgeInsetsGeometry? contentPadding;

  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    String label = semanticLabel!;

    if (title != null) {
      children.add(Padding(
        padding: titlePadding ??
            EdgeInsets.fromLTRB(24.0, 24.0, 24.0, content == null ? 20.0 : 0.0),
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.titleMedium!,
          child: Semantics(child: title, namesRoute: true),
        ),
      ));
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
          label = semanticLabel!;
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          label = (semanticLabel ??
              MaterialLocalizations.of(context).alertDialogLabel);
      }
    }

    if (content != null) {
      children.add(Flexible(
        child: Padding(
          padding: contentPadding!,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.subtitle1!,
            child: content!,
          ),
        ),
      ));
    }

    Widget dialogChild = IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );

    if (label != null)
      dialogChild =
          Semantics(namesRoute: true, label: label, child: dialogChild);

    return Dialog(child: dialogChild);
  }
}

class SimpleDialogOption extends StatelessWidget {
  /// Creates an option for a [SimpleDialog].
  const SimpleDialogOption({
    Key? key,
    this.onPressed,
    this.child,
  }) : super(key: key);

  final VoidCallback? onPressed;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          child: child),
    );
  }
}

class SimpleDialog extends StatelessWidget {
  const SimpleDialog({
    Key? key,
    this.title,
    this.titlePadding = const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
    this.children,
    this.contentPadding = const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
    this.semanticLabel,
  })  : assert(titlePadding != null),
        assert(contentPadding != null),
        super(key: key);

  final Widget? title;

  final EdgeInsetsGeometry? titlePadding;

  final List<Widget>? children;

  final EdgeInsetsGeometry? contentPadding;

  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final List<Widget> body = <Widget>[];
    String? label = semanticLabel;

    if (title != null) {
      body.add(Padding(
          padding: titlePadding!,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.titleMedium!,
            child: Semantics(namesRoute: true, child: title),
          )));
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
          label = semanticLabel;
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          label =
              semanticLabel ?? MaterialLocalizations.of(context).dialogLabel;
      }
    }

    if (children != null) {
      body.add(Flexible(
          child: SingleChildScrollView(
        padding: contentPadding,
        child: ListBody(children: children!),
      )));
    }

    Widget dialogChild = IntrinsicWidth(
      stepWidth: 56.0,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 280.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: body,
        ),
      ),
    );

    if (label != null)
      dialogChild = Semantics(
        namesRoute: true,
        label: label,
        child: dialogChild,
      );
    return Dialog(child: dialogChild);
  }
}

class _DialogRoute<T> extends PopupRoute<T> {
  _DialogRoute({
    @required this.theme,
    bool barrierDismissible = true,
    this.barrierLabel,
    @required this.child,
    RouteSettings? settings,
  })  : assert(barrierDismissible != null),
        _barrierDismissible = barrierDismissible,
        super(settings: settings);

  final Widget? child;
  final ThemeData? theme;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 150);

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  Color get barrierColor => Colors.black54;

  @override
  final String? barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return SafeArea(
      child: Builder(builder: (BuildContext context) {
        final Widget annotatedChild = Semantics(
          child: child,
          scopesRoute: true,
          explicitChildNodes: true,
        );
        return theme != null
            ? Theme(data: theme!, child: annotatedChild)
            : annotatedChild;
      }),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child);
  }
}

Future<T?> customShowDialog<T>({
  @required
      BuildContext? context,
  bool barrierDismissible = true,
  @Deprecated(
      'Instead of using the "child" argument, return the child from a closure '
      'provided to the "builder" argument. This will ensure that the BuildContext '
      'is appropriate for widgets built in the dialog.')
      Widget? child,
  WidgetBuilder? builder,
}) {
  assert(child == null || builder == null);
  return Navigator.of(context!, rootNavigator: true).push(_DialogRoute<T>(
    child: child ?? Builder(builder: builder!),
    theme: Theme.of(context),
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
  ));
}
