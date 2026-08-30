# FinBrain(핀브레인)
An AI-powered application for searching, anaylzing and comparing financial products.
<br><br>

### 🛠️ Tech Stack
> FrameWork & Language: Flutter & Dart
> Architecture: MVVM, Repository Pattern
> Network: HTTP
> State Management: Riverpod
> Database: Firebase Firestore
> Authentication: Firebase Authentication

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
___
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