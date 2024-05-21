# Decentro Fabric SDK

Welcome to the **Decentro Fabric SDK**! This Flutter SDK allows you to seamlessly integrate UIStream workflows into your applications. With UIStream, you can empower your users to interact with Decentro's powerful features while maintaining a near-native experience.

## Features

- **UIStream Flows**: UIStream flows provide dynamic UI components for specific functionalities. Here are some of the most commonly used flows:

  - **AADHAAR**: Retrieve Aadhaar documents from sources like DigiLocker, UIDAI, or CKYC and send the document BASE64 in the callback URL.
  - **DIGILOCKER**: Streamline the entire DigiLocker workflow through a single API, enabling seamless interaction with DigiLocker services.
  - **CAR_INSURANCE_POLICY**: Fetch Car Insurance Policy documents dynamically from issuers on DigiLocker.
  - **VEHICLE_REGISTRATION_CERTIFICATE**: Obtain Vehicle Registration Certificate documents in real-time from DigiLocker.

## Getting Started

1. **Installation**: Add the Decentro Fabric SDK to your `pubspec.yaml` file:

   ```yaml
   dependencies:
     decentrotech_fabric: ^0.1.2
   ```

2. **Usage**:

   Generate UIStream Session link as [documented here](https://docs.decentro.tech/docs/kyc-and-onboarding-workflows-uistreams).

   Use the following snippets as guides to add UIStream to your Flutter app.

   ```dart
   import 'package:decentrotech_fabric/decentrotech_fabric.dart';

   // Initialize UIStream Screen
    UIStreamWebView(
      uistreamUrl: "<uistream_session_link>",
    );
   ```

   ```dart
   // Example: Configure UIStream Route
   onGenerateRoute: (RouteSettings routeSettings) {
    return MaterialPageRoute<void>(
        settings: routeSettings,
        builder: (BuildContext context) {
            switch (routeSettings.name) {
                case "/<uistream_route>":
                    return UIStreamWebView(
                        uistreamUrl: "<uistream_session_link>",
                    );
                default:
                    return DefaultScreen()
            }
        }
    )
   }
   ```

3. **API Documentation**: Explore the detailed [UIStreams documentation](https://docs.decentro.tech/docs/kyc-and-onboarding-workflows-uistreams) for more information.

4. **Sample App**: Check out our [sample app on GitHub](https://github.com/decentro-in/decentro-fabric-flutter-sdk-sample) to see UIStream in action.

## License

This SDK is closed-source and proprietary. Please refer to the [LICENSE.md](LICENSE.md) file for licensing details.

---

_Decentro_ - Building the future of fintech infrastructure 🚀
Learn more at [decentro.tech](https://decentro.tech/)
