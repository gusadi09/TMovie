# 🎬 TMovie App

A clean and simple **iOS app** develop entirely with **SwiftUI** and **no third-party libraries** — 100% vanilla Swift.  
This app fetches movie data from [The Movie Database (TMDB)](https://www.themoviedb.org/) using their public API.

---

## 🚀 Getting Started

Follow these steps to build and run the project successfully.

---

### 🧰 Requirements

Before starting, make sure you have:

| Tool | Version |
|------|----------|
| Xcode | 16.0 or later |
| Swift | 6.0 or later |
| TMDB API Access Token | Required |

You can create a TMDB account and generate an access token here:  
👉 [https://www.themoviedb.org/settings/api](https://www.themoviedb.org/settings/api)

---

### 📦 Clone the Repository

Open **Terminal** and run:

```bash
git clone https://github.com/gusadi09/TMovie.git
cd TMovie
```

---

### 🔑 Add Your TMDB Access Token

Before running the app, open the project and find the file that contains the placeholder:

```swift
guard KeychainManager.shared.save(token: "[TMDB_ACCESS_TOKEN_AUTH]") else { return }
```

Replace the placeholder `[TMDB_ACCESS_TOKEN]` with your actual TMDB access token:

```swift
guard KeychainManager.shared.save(token: "eyJhbGciOiJIUzI1NiJ9...") else { return } // your TMDB token here
```

> 💡 **Tip:** Never commit your real token to a public repository!  
> You can use a `.gitignore` file or local-only config file to keep it private.

---

### 🧱 Open the Project

Double-click on the `.xcodeproj` file or open it via Terminal:

```bash
open TMovie.xcodeproj
```

---

### ▶️ Run the App

1. In Xcode, select a **Simulator** (e.g., *iPhone 16 Pro*)  
2. Press **Run (▶️)** in the top toolbar  
3. Wait for the build to finish — your app will launch automatically

---

## ⚙️ Troubleshooting

**Build failed?**  
- Make sure you’re using **Xcode 16 or later**  
- Clean the build folder: `Shift + Cmd + K`  
- Reopen Xcode and rebuild

**App not showing data?**  
- Double-check your TMDB access token  
- Ensure your internet connection is active  
- The API might have rate limits — try again later

---

## 📄 License

This project is licensed under the **MIT License**.  
You’re free to use, modify, and share this project.

---

## 🖼️ Screenshot

Add screenshots of your app’s interface here:

<img width="511" height="966" alt="image" src="https://github.com/user-attachments/assets/33bb427c-b589-428f-85d2-059158e2ee72" />
<img width="511" height="966" alt="image" src="https://github.com/user-attachments/assets/362134a4-a610-41ae-b652-2ffc075a7cfc" />
<img width="511" height="966" alt="image" src="https://github.com/user-attachments/assets/899901e4-538a-4f74-ba04-928e2af7242f" />
<img width="511" height="966" alt="image" src="https://github.com/user-attachments/assets/eed5f390-bb2e-4cfc-9789-f96ddba7cffb" />

## 👨🏻‍💻Decision Making & Challenge During Development

Before development, I made several decisions included develop the app using SwiftUI and use MVVM for architecture. I decide to used SwiftUI because able to develop UI faster than UIKit and fit for simple mini project. The other one, I used MVVM (Model-View-ViewModel) as architecture because MVVM is quite simple architecture and fit with SwiftUI pattern.

During the development I facing problems like arrange the UI. because I'm not an person with design sense I just trying to face this problem by only using the system components and little bit custom components. I try to maximize the implementation and make the UI straight forward. But, for the technical code development I doesn't face any problem.



