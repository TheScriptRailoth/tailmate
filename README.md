# 🐾 Tailmate – Pet Adoption App (Flutter + Web)

**Tailmate** is a cross-platform Flutter application that helps users discover and adopt pets. It offers a clean, responsive UI for both mobile and web platforms, with features like pet listing, pet details, favorites, and image handling.  

---

## 🚀 Features

- 🐶 View a list of pets with images, age, and price.
- ❤️ Mark pets as favorite.
- 📄 View detailed information about each pet.
- 🌐 Responsive UI for both **mobile and web**.
- ⚙️ Hosted API on Vercel with mock data (JSON-based).
- 🧩 Hero animations and custom card clipping for visual polish.
- 🔐 CORS-enabled API integration for Flutter Web.

---

## 📸 Screenshots

### 🏠 Home Page
| Light Mode | Dark Mode |
|------------|-----------|
| ![Home Light](assets/screenshots/home_light.png) | ![Home Dark](assets/screenshots/home_dark.png) |

### 🏠 Home Page Category
| Light Mode                                                    | Dark Mode                                                   |
|---------------------------------------------------------------|-------------------------------------------------------------|
| ![Home Category Light](./assets/screenshots/category_light.png) | ![Home Category Dark](./assets/screenshots/category_dark.png) |

### 🔍 Search Page
| Light Mode | Dark Mode |
|------------|-----------|
| ![Search Light](./assets/screenshots/search_light.png) | ![Search Dark](./assets/screenshots/search_dark.png) |

### 📋 Search Results Filter
| Light Mode                                                  | Dark Mode                                                 |
|-------------------------------------------------------------|-----------------------------------------------------------|
| ![Search Result Light](./assets/screenshots/filter_light.png) | ![Search Result Dark](./assets/screenshots/filter_dark.png) |

### 📋 Search Results
| Light Mode                                                                | Dark Mode |
|---------------------------------------------------------------------------|-----------|
| ![Search Result Filter Light](./assets/screenshots/search_result_light.png) | ![Search Result Dark](./assets/screenshots/search_result_dark.png) |

### 📂 Drawer
| Light Mode | Dark Mode |
|------------|-----------|
| ![Drawer Light](./assets/screenshots/drawer_light.png) | ![Drawer Dark](./assets/screenshots/drawer_dark.png) |

### ❤️ Favorites Page
| Light Mode | Dark Mode |
|------------|-----------|
| ![Favorites Light](./assets/screenshots/favourite_light.png) | ![Favorites Dark](./assets/screenshots/favourite_dark.png) |

### 🕓 Filter History
| Light Mode | Dark Mode |
|------------|-----------|
| ![Filter History Light](./assets/screenshots/history_light.png) | ![Filter History Dark](./assets/screenshots/history_dark.png) |

### 📄 Details Page
| Light Mode | Dark Mode |
|------------|-----------|
| ![Details Light](./assets/screenshots/details_light.png) | ![Details Dark](./assets/screenshots/details_dark.png) |


---

## 🌐 Live Web Demo

👉 **[Try the Web App](https://tailmate-web-azure.vercel.app/)** (Hosted on Vercel)

---

## 📦 APK & Code

- 🔗 **[GitHub Repository](https://github.com/TheScriptRailoth/tailmate)**
- 📱 **[Download APK](https://drive.google.com/file/d/1dbcDEWxoMB8SykIlPc1jo05hqMjRcjGJ/view?usp=sharing)**

---

## 🛠️ Tech Stack

- **Frontend:** Flutter (Dart)
- **Backend:** Node.js (Vercel Serverless Functions)
- **State Management:** `flutter_bloc`
- **Hosting:** Vercel (API & Web)
- **Storage:** JSON file-based mock data

---

## 🗂️ Folder Structure

```bash
    
tailmate/
│
├── lib/
│ ├── cubits/
│ ├── models/
│ ├── screens/
│ └── widgets/
├── build/web/ # Web output folder (for hosting)
├── api/ # Vercel serverless backend
├── data/pets.json # Mock pet data
├── pubspec.yaml
└── README.md
    
```
---

## 🧪 Run Locally

```bash
# Clone the repo
git clone https://github.com/yourusername/tailmate.git
cd tailmate

# Get dependencies
flutter pub get

# Run on Android
flutter run

# Run on Web
flutter run -d chrome

# Build for Web
flutter build web

```
----

## ☁️ Deployment Notes

- Only the build/web folder is deployed to Vercel due to the 100MB limit.
- Backend API is hosted via Vercel serverless functions inside /api.
- A vercel.json is used to route API requests properly.

---

## 🙏 Acknowledgements
Thanks to Posha for the opportunity and for providing the assessment prompt.
Built with ❤️ by Ashutosh Mishra.

---

## 📧 Contact

- 📧 Email: am3718440@gmail.com

- 🔗 LinkedIn: @thescriptrailoth

- 📱 Phone: +91-8423979654
