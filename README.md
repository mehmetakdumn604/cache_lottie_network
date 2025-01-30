# Cached Lottie Network

A Flutter package that helps you cache and display Lottie animations from network URLs with offline support. This package automatically saves Lottie animations to local storage, allowing your app to display animations even when offline.

## Features

- ✨ Cache Lottie animations for offline use
- 🔒 Secure local storage using flutter_secure_storage
- 🌐 Network connectivity handling
- ⚡ Fast loading from cache
- 🎨 Built-in loading widget support

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  cached_lottie_network: ^0.0.2
```

## Usage

### Basic Usage

```dart
CacheLottieNetwork(
  lottieUrl: "https://example.com/animation.json",
  cacheKey: "unique_key_1",
)
```

## Important Notes

1. Always use unique cache keys for different animations
2. The animation will be automatically cached when:
   - The device has internet connection and downloads the animation
   - Once cached, it will be available offline
3. The package handles:
   - Automatic caching of animations
   - Network connectivity checks
   - Secure storage of animation data

## Dependencies

- connectivity_plus: ^6.1.2
- dio: ^5.2.1+1
- flutter_secure_storage: ^9.2.4
- lottie: ^3.1.3

## Contributing

Feel free to contribute to this project by creating issues or submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
