# CAPARC

A Flutter mobile app for browsing, uploading and reading student capstone projects. Users sign in, search the archive by course, save favorites, and download projects to read inside the app.

## Features

- **Auth and accounts**: Firebase sign-in, change email and password with re-authentication.
- **Upload flow**: multi-step capstone upload (details, verification, review) with PDF file picking.
- **Search and browse**: home feed with time-of-day greeting, course picker and search.
- **Favorites**: like a project and find it again in a favorites tab.
- **Downloads**: files are saved for in-app viewing only, with a built-in PDF viewer.
- **Profile**: edit profile details and avatar.

## Tech stack

- Flutter / Dart, `flutter_bloc` (one bloc per feature: home, search, favorites, downloads, upload, profile, user)
- Firebase Auth, Cloud Firestore and Cloud Storage
- `dio` for downloads, `easy_pdf_viewer`, `file_picker`, `flutter_dotenv`

## Project layout

```
lib/
  blocs/     state management, one folder per feature
  common/    models, enums, shared widgets (dialogs, modals, pickers), colors
  pages/     screens
assets/      images and illustrations
```

## Getting started

```bash
flutter pub get
touch .env          # the app loads .env at startup; add your own values
flutter run
```

You need your own Firebase project (`flutterfire configure`). Do not commit `.env`.

## Status

Redesign of an earlier version; see the open issues for known bugs (avatar display, in-app-only downloads, date picker).
