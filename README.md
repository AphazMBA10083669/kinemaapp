# Kinema Final Part

Kinema is an Android application designed to function as a comprehensive entertainment database, similar to IMDb, with a focus on movies, TV shows, video games, and industry professionals. This app uses Kotlin and integrates various features to enhance the user experience, including SSO with Google, RESTful APIs, Azure Blob Storage, biometric authentication, offline mode, and multi-language support.

Features

1. Sign In Page 
   The application opens with a Sign In page, where users can log in via Google SSO or choose other login options. This page serves as the main entry point for user authentication.

2.Single Sign-On (SSO) with Google  
   The app supports Google Sign-In for seamless authentication. Users can log in using their Google account, providing a quick and secure way to access the app.

3. IMDb API Integration  
   The app integrates with the IMDb API (via RapidAPI) to provide detailed information on movies coming form top rated or popular, and even from premeiring or upcoming films. Users can search, browse, and view information directly sourced from IMDb API.

4. Custom RESTful API 
   The application is built with a custom RESTful API to manage backend operations, offering efficient data retrieval and storage while keeping the app’s content dynamic and up-to-date.
   
6. Search Bar 
A person can search for their specific movie in the search bar

7. Rating 
  The application once a user selects their movie after searching, the user can rate it from 1 to 5 stars in the represation of the emojies(the slidebar)

8. Biometric Authentication
   For enhanced security, biometric authentication (such as fingerprint or face recognition) is implemented. This allows users to quickly and securely access the app using their device's biometric sensors.

9. Offline Mode  
   The app includes an Offline Mode feature to allow users to access previously viewed data without an active internet connection. Data syncs when a connection is re-established.

10. Multi-Language Support
   Multi-language support enables users to switch between English and two South African languages, ensuring a more inclusive user experience. The languages can be changed via the settings.

11. Push Notifications  
   Push notifications keep users informed of updates, recommendations, and news within the app, enhancing engagement and delivering timely information.

12. Settings Pages 
    Kinema includes several settings pages for users to personalize their experience:
    - User Profile Page: Edit profile details, such as username and profile picture.
    - Security Page: Manage login credentials and biometric authentication.
    - Notification Settings: Customize notification preferences.
    - Privacy Page**: Configure data privacy options.
    - Help and Support Page: Access customer support and FAQs.
    - Terms and Policies Page: Review the app’s terms and conditions and privacy policies.

## Getting Started###

### Prerequisites###
- Android Studio (latest version recommended)
- Using Flutter for Android development for this king of application
- Google Account for SSO integration
- RapidAPI account to gain access to the IMDb API access
- Firebase for saving user Information(sign-up info and langages)

### Installation ###

1. Clone the repository: https://github.com/AphazMBA10083669/kinemaapp.git
   
   git clone: https://github.com/AphazMBA10083669/kinemaapp.git

2. Open the project in Android Studio.

3. Set up your API keys and OAuth credentials for Google SSO, IMDb API (RapidAPI), and Azure Blob Storage in the project’s `local.properties` or environment variables.

4. Install the Flutter SDK and the Dart SDK

5. Build and run the application on an Android device or emulator.

###  Permissions ###
- Internet access
- Biometric access
- Push notification permissions

##Technologies Used ###

- Kotlin for Android development
- Google SSO API for secure login
- IMDb API via RapidAPI for fetching entertainment data
- Custom RESTful API for backend operations
- Firbase for secure media storage and user information
- Push Notifications via Firebase
- Multi-language support with localization for English and three South African languages

## Contributing

We welcome contributions! If you have suggestions or want to contribute, please create an issue or submit a pull request.

## License

This project is licensed under the MIT License. See `LICENSE.md` for details.

## Privae Policy

Here is the link that will take you to our terms of private policy: https://www.freeprivacypolicy.com/live/5249defc-0590-4331-990f-cf49d77d246a

## Terms and Conditions

Here is link for this apps terms and conditions for the user: https://www.freeprivacypolicy.com/live/7e30a672-e02e-484a-88c1-50178f95071c

```

## Authors

- [Aphiwe Lanhgalethu Mbonambi](https://github.com/AphazMBA10083669)

- [Smiso Zwakele Ndwandwe](https://github.com/SmisoZwakeleNdwandwe)

- [Siyabonga Avumile Baqwa](https://github.com/bonga22)


## Contact

[Aphhwe Mbonnambi](ST10083669@vcconnect.edu.za)

[Smiso Zwakele Ndwandwe](st10083277@vcconnect.edu.za)

[Siyabonga Avumile Baqwa](st10116698@vcconnect.edu.za)


## Demo

Youtub Link: https://youtu.be/3wQazIJNyXg

# How to Download and run

This project is a starting point for a Flutter application which was made nessacary for this IMDB-like applicaion.

A few resources to get for your devicice for you to use use the app:

- [Installing Flutter SDK][(https://docs.flutter.dev/get-started/install])
- [Installing Dart SDK]([https://docs.flutter.dev/get-started/install/windows/mobile])

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
