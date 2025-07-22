# CoreArchitectureDemo

This project is a **proposed mobile architecture for PickMe** (Sri Lanka’s leading super app), designed to address challenges around **scalability**, **modularization**, **debuggability**, and **state consistency** in large, multi-vertical applications.

---

## Why This Architecture?

As PickMe grows to include multiple verticals—Rides, Foods, Flash, Events, and more—it becomes critical to:

- Maintain **predictable UI state** across complex flows
- Ensure **team-level independence** for each vertical
- Enable **centralized logging, debugging, and analytics**
- Prevent fragile and coupled codebases from slowing development

This architecture solves these problems through a combination of:

- **Unidirectional Data Flow (UDF)** inspired by ReSwift
- **Global App State** composed of feature-level substates
- **Middleware pipeline** for tracking, logging, and async handling
- **Action-based state transitions** for full auditability and testability
- **Modular code organization** to isolate and scale features independently

---

## Key Modules

- `CoreArchitecture/`
  - Defines `AppState`, reducers, and middleware
  - Owns the root `Store` and dispatch pipeline
- `Features/` (e.g., Rides, Events, Auth)
  - Each vertical encapsulates its own state, actions, reducer, and views
- `Middleware/`
  - Includes `actionTrackingMiddleware` to log all dispatched actions

---

## Current State

This is a working demonstration of the architectural pattern. It includes:

- Example verticals like Rides and Events
- Action tracking via middleware
- Modular state composition via `AppState`

---

## Future Directions

- Add navigation-state middleware
- Introduce Live Activities and background sync hooks

---

## Related Technologies

- [ReSwift](https://github.com/ReSwift/ReSwift)
- Uses Combine-based state observation
- Built with SwiftUI and a modular Swift Package layout

---

> For questions or contributions, feel free to raise an issue or start a discussion.
