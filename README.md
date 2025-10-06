# Job Portal App

A Flutter job portal app built using **SQLite** and **Riverpod**, following the **MVVM** architecture.  
It allows user authentication, fetching jobs from an API, saving applied jobs locally, and managing user data.

---

## Features

- **Authentication**
    - User registration with **duplicate email check**.
    - Login and logout functionality.
    - Profile data saved locally using SQLite.

- **Job Listing**
    - Fetches job data from an API on app launch with state handle.
    - **Refresh button** to reload data.
    - Job list displayed in the **homepage** with all job short details.

- **Job Details**
    - Click on any job to view full details.
    - **Apply button** saves the job locally in SQLite linked to the **current user email**.

- **Saved Jobs**
    - Separate page to show all **applied/saved jobs** for the current user.
    - Delete button to remove jobs from local database.

- **User Profile**
    - App drawer displays **user profile information**.
    - Shows **number of applied jobs** for the logged-in user.

- **Form Validation**
    - All forms are properly validated (registration, login).

- **Architecture**
    - Follows **MVVM** pattern for maintainable and scalable code.
    - **Riverpod** used for state management.
    - **SQLite** used for local storage of users and applied jobs.

---

## How It Works

1. **Registration & Login**
    - Users register with full name, email and password.
    - Duplicate emails are checked in SQLite.

2. **Homepage**
    - Fetches job data from API once at app start.
    - Pull to refresh to reload API data.

3. **Job Details**
    - Click on a job to view full details.
    - Apply button saves job locally for the **current logged-in user**.

4. **Saved Jobs**
    - Shows all applied jobs for the current user.
    - Delete button removes the job from SQLite.

5. **App Drawer**
    - Shows user profile info and number of applied jobs.

---