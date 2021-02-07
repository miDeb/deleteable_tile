# deleteable_tile

[![Pub](https://img.shields.io/pub/v/deleteable_tile)](https://pub.dartlang.org/packages/deleteable_tile)

<img src="https://raw.githubusercontent.com/miDeb/deleteable_tile/main/example/example.gif" height="600">

## Usage

For basic usage, use the `DeleteableTile` widget. It places an `IconButton` next to the `child`. Pressing that button triggers a delete animation, and after its completion `onDeleted` is called.

```dart
DeleteableTile(
  key: ValueKey(value),
  onDeleted: () => _children.remove(value),
  axisAlignment: axisAlignment,
  child: Text("delete me"),
);
```

For more advanced usage, use the `Deleteable` widget. It accepts a builder which is called to build the child, and supplies a `delete` callback. Call it to trigger a delete animation, and `await` it to wait for the completion of the animation.

```dart
Deleteable(
  builder: (context, delete) => Card(
    child: Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () async {
                await delete();
                _children.remove(value);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.delete),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Delete"),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 75,
          child: Center(
            child: Text("Delete me as well!"),
          ),
        )
      ],
    ),
  ),
);
```

**In both cases:**

After the animation has finished, remove the widget from the tree (i.e. do not rebuild the widget again after it has been deleted).

If you are using those widgets in a `Column` or a `ListView` don't forget to supply a unique key!
