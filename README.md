# material_speed_dial

A simple Material speed dial.

## Preview

![Preview](./arts/demo.gif)

## Usage

1. Add to your dependencies

```yaml
dependencies:
  material_speed_dial: 0.0.7
```

2. Add to your widget tree

```dart
class MyHomePage extends StatelessWidget {
  final _key = GlobalKey<SpeedDialState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        key: _key,
        invokeAfterClosing: true,
        child: Icon(Icons.add),
        expandedChild: Icon(Icons.share),
        backgroundColor: Colors.blue,
        expandedBackgroundColor: Colors.black,
        children: [
          SpeedDialChild(
            child: Icon(Icons.close),
            label: Text('Test'),
            onPressed: () {},
          ),
          SpeedDialChild(
            child: Icon(Icons.pending),
            label: Text('Another Test'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
```

3. Check for state or toggle

```dart
final isOpen = _key.currentState.isOpen;
```
```dart
_key.currentState.toggle();
```