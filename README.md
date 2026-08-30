# 핀브레인(FinBrain)
An AI-powered application for searching, anaylzing and comparing financial products.

### 🔗 Links
> 🍎 **App Store**: https://apps.apple.com/us/app/핀브레인/id6796775538
> <br>
> 📄 **Portfolio(English)**: https://heliotrope-son-4ff.notion.site/FinBrain-3cc4ef68c518807aafeeff8dc7a5fa0a
> <br>
> 📄 **Portfolio(Korean)**: https://heliotrope-son-4ff.notion.site/34a4ef68c51881e3898ac7667cacc6d5
<br>

### 🎬 Demo

https://github.com/user-attachments/assets/51ad6db1-129f-4566-8ac6-92eb7f1d82d1

<br>

### 🛠️ Tech Stack
```
FrameWork & Language: Flutter & Dart
Architecture: MVVM, Repository Pattern
Network: HTTP
State Management: Riverpod
Database: Firebase Firestore
Authentication: Firebase Authentication
```

### 📚 Libraries
> #### State Management
> Riverpod
> #### Network & Data
> HTTP · XML2JSON · Charset Converter · Intl
> #### Backend & Authentication
> Firebase Auth · Firestore · Cloud Functions · Firebase AI · Google Sign-In
> #### UI / UX
> Flutter SVG · Split View · Smooth Page Indicator · Tutorial Coach Mark
> #### Security
> Encrypt · Flutter Dotenv

<br>

### 📁 Structure
```
project/
├── assets/
│   ├── icon/
│   ├── images/
│   │   └── onboarding/
│   └── privacy_policy.md
│
└── lib/
    ├── data/
    │   ├── data_source/
    │   ├── model/
    │   └── repository/
    │
    ├── themes/
    │
    └── ui/
        ├── screen/
        ├── viewmodel/
        └── widget/
```
<br>

### 📚 Git Convention
#### Naming Rules
- Use lowercase, - and /
- Use prefix written below

| prefix     | explanation                       |
|------------|-----------------------------------|
| `feat`     | Add new features                  |
| `fix`      | Resolve standard bugs or issues   |
| `refactor` | Improve or restruct code without changing its behavior     |
| `hotfix`   | Resolve critical issues           |
| `style`    | Change UI design                  |
| `docs`     | Add or modify document            |
| `release`  | Release branch                    |

#### PR Convention
- Do not push commits in main directly
- Submit screenshot while adding new features
- Use Squash and Merge options while merging
- Delete merged branch
