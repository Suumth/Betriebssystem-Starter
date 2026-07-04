# Xcode 27 Skill Routing

Use this note to route Apple-platform tickets to the local Xcode 27 reference
skills without copying their manuals into this repo or into target project repos.

## Source

GitHub/Cloud-KI entrypoint:

- use this repo-facing note through its GitHub URL.

Local Codex/local-agent fallback and reference only:

```text
<LOCAL_TOOL_REFERENCE_PATH>
```

Do not copy or commit the exported skill files or reference manuals into public
or production repositories unless redistribution and license status are
explicitly clarified.

If the local folder is unavailable, state that in the closeout. Classify missing
reference material as `missing_tool` or `missing_context` when it blocks the
ticket, and continue only when the issue can still be satisfied from GitHub,
repo rules and evidence.

## When to Load

Load this note only for Apple-platform work: SwiftUI, UIKit, Xcode build
settings, iOS/macOS builds, simulator or device testing, StoreKit, Live
Activity, Widget, Watch, Apple-platform QA or C/C++ bounds-safety work in an
Apple project.

Do not load Xcode 27 skills for non-Apple tickets, generic docs work, web work,
marketing work or routine method-repo edits unless the ticket explicitly asks
for Apple-platform skill routing.

## Inventory and Routing

Read the relevant local `SKILL.md` first, then only the referenced detail files
needed for the task.

| Local skill | Use when |
| --- | --- |
| `swiftui-specialist` | Writing, editing or reviewing SwiftUI views, data flow, environment usage, modifiers, localization, `ForEach`, animations or soft deprecations. |
| `swiftui-whats-new-27` | SDK 27 SwiftUI changes, `@State` macro compile errors, new SwiftUI 27 APIs, toolbars, reorder, swipe actions, document apps, `AsyncImage`, hard deprecations or SDK 27 source incompatibilities. |
| `device-interaction` | Simulator/device UI verification, screenshots, hierarchy inspection, touch interaction checks or debugging UI behavior after a UI-affecting change. |
| `test-modernizer` | Modernizing existing XCTest or Swift Testing suites. Do not use it merely to write brand-new tests from scratch. |
| `audit-xcode-security-settings` | Xcode security build settings, Enhanced Security, static analyzer, compiler-warning posture or hardening diagnostics. Do not use it for TLS/ATS, signing or privacy API questions. |
| `uikit-app-modernization` | UIKit modernization around multi-window behavior, `UIScreen.main`, `interfaceOrientation`, scene lifecycle, safe areas or legacy shared-state APIs. |
| `c-bounds-safety` | C/C++ `-fbounds-safety`, pointer annotations, `ptrcheck.h`, bounds-safe buffer adoption or runtime bounds debugging. |

## Ticket Guidance

For Apple-platform tickets, list `Xcode 27` under `Skills` when the work touches
the areas above. The issue still must define its own scope, validation and
evidence. Loading a skill note does not prove build, simulator, device, StoreKit,
Widget, Watch or Live Activity behavior.

For Xcode, simulator, device or build validation, prefer raw command output,
screenshots, hierarchy excerpts or other artifact evidence in the PR body.

Xcode 27 skills are skill context, not required subagents, PM roles, labels,
runners or a permanent org chart.
