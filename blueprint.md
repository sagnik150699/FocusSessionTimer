
# Project Blueprint: Focus Session Timer

## Overview

This document outlines the design, features, and development plan for the "Focus Session Timer," a Flutter application designed to help users stay focused during work or study sessions. The core concept is a gamified timer where a user's focus time nurtures a virtual creature.

## Implemented Features (v1.2.1)

### Core Functionality
- **Customizable Session Timer:** A countdown timer that the user can start, stop, and reset.
- **Circular Time Slider:** A `sleek_circular_slider` allows users to intuitively set their desired focus duration from 0 to 60 minutes.
- **Creature Growth:** A virtual creature that grows and evolves as the user successfully completes focus sessions.
- **Penalty System:** The creature's growth is penalized if the user interrupts a session.
- **State Management:**
    - `TimerProvider`: Manages the timer state (running, stopped, duration).
    - `CreatureProvider`: Manages the creature's state (growth level, particles).
    - `ThemeProvider`: Manages the application's theme (light/dark mode).

### UI & Design
- **Theme:**
    - **Material 3:** Utilizes the latest Material Design principles.
    - **Color Scheme:** Based on a `deepPurple` seed color, generating harmonious light and dark themes.
    - **Typography:** Uses the `Montserrat` font from `google_fonts` for a clean, modern look.
    - **Theming:** Centralized theme data for consistent component styling (`ElevatedButton`, `Card`, `AppBar`) with "glow" effects.
    - **Theme Toggle:** An icon button in the `AppBar` allows users to switch between light and dark modes.
- **Layout:**
    - A single-screen, scrollable interface (`HomeScreen`).
    - A gradient background for visual appeal.
    - A central `Card` element that contains the timer and the creature, creating a focal point with a "lifted" shadow effect.
    - **Responsive Buttons:** The control buttons are in a `Wrap` widget to prevent overflow on smaller screens.
- **Creature Animation:**
    - The creature has a subtle "pulsing" animation using `simple_animations`.
    - Particle effects appear when the creature grows.
- **Accessibility & UX:**
    - **Haptic Feedback:** Buttons provide tactile feedback on press.
    - **Tooltips:** All interactive elements have tooltips for improved accessibility.
    - **Icons:** Buttons have icons to clarify their function.

## Current Plan

- **Implement Session History:**
  - Create a `Session` model to store the data for each focus session (duration, completion status).
  - Create a `HistoryProvider` to manage the list of sessions.
  - Create a `HistoryScreen` to display the session history.
  - Add a button to the `HomeScreen` to navigate to the `HistoryScreen`.
