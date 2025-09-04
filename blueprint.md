
# Focus Session Timer Blueprint

## Overview

This document outlines the blueprint for a Flutter application designed to help users focus by gamifying their work sessions. The application features a timer and a virtual creature that grows as the user maintains focus and is penalized if the session is interrupted.

## Style and Design

- **Theme:** The application uses a Material 3 theme with a green primary color. It supports both light and dark modes, with a toggle in the app bar.
- **Typography:** The `google_fonts` package is used to import and apply the 'PT Sans' font for a clean and modern look.
- **Layout:** The main screen has a simple, centered layout with a column of widgets, including a title, timer, creature, and session control buttons.

## Features

- **Focus Timer:** A 25-minute countdown timer to structure focus sessions.
  - Users can start, stop, and reset the timer.
- **Creature Growth:** A virtual creature that evolves as the user progresses through focus sessions.
  - The creature is represented by a growing 'eco' icon.
  - The creature grows every 5 minutes (300 seconds) of a focus session.
  - The creature is penalized (shrinks) if a session is stopped prematurely.
- **Theme Toggle:** A button in the app bar to switch between light and dark modes.

## Current Plan

- **Implement Creature Growth:**
  - Create a `CreatureProvider` to manage the creature's growth state.
  - Create a `CreatureWidget` to display the creature.
  - Integrate the `CreatureProvider` and `CreatureWidget` into the main application.
  - Connect the `TimerProvider` to the `CreatureProvider` to trigger growth and penalties.

