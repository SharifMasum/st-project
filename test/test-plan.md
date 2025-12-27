# Test Plan – Shared Todo List App (swt-todo-list-app)

## Goal
Test the shared todo list application to:
- Identify and document reproducible functional/usability issues through manual testing
- Verify the most important user flows with automated end-to-end (E2E) tests
- Verify key backend API behaviour with automated API tests
- Ensure automated tests run reliably in CI on each push 

This plan focuses on practical coverage of core features rather than exhaustive production-grade testing.

---

## In scope
### Manual exploratory testing (UI)
- Explore the web UI and identify reproducible issues related to functionality or usability.
- Focus areas:
  - Authentication: register, login, logout
  - Todo lists: create, view, edit (name/description), delete
  - Todo items: create, edit description, delete
  - Sharing: share list with another user, view shared list as recipient
- Verify each issue is reproducible after restarting the app in a fresh instance.

### Automated E2E testing (Robot Framework + Browser)
Automated E2E tests will cover the listed user stories as “happy path” flows:
- Register to the application
- Log in to the application
- Log out from the application
- Create and delete todo lists
- Modify a todo list’s name and description
- Create and delete todo items in a todo list
- Edit a todo item’s description
- Share a todo list with another user
- View a todo list that is shared with me, including todo items

### Automated API testing
Automated API tests will cover backend endpoints discovered from:
- `http://localhost:4322/docs`

Coverage goal includes endpoints from:
- Authentication
- Todo lists CRUD
- Todo items CRUD
- Sharing

Basic validations:
- Status codes
- Key response fields
- Auth requirements (token required vs public) where relevant

### CI (GitHub Actions)
- CI workflow runs E2E tests on each push to the private repository.
- Smoke E2E tests (subset) on push vs full E2E suite nightly
- Separate workflow for API tests
- Non-functional automated check (e.g., dependency scan or static analysis)

---

## Out of scope
The following are not fully addressed due to limited project scope, but would be important for a production application:

### Additional functional testing
- Extensive negative testing for all forms and edge cases (very long inputs, unusual characters, unicode, boundary values)
- Full permissions/roles matrix testing for sharing (multiple recipients, role changes, revocation flows)
- Concurrency testing (multiple users editing same list/items at the same time)

### Non-functional testing (production-level)
- Performance/load testing (many users, large amounts of lists/items)
- Comprehensive security testing (OWASP risks, session handling, penetration testing)
- Accessibility testing beyond basic checks (screen reader testing, keyboard-only usability)
- Cross-browser / cross-device testing (Safari/iOS, mobile responsiveness, different viewports)
- Observability & operational readiness (logging/monitoring/alerts, backups)

### Improved E2E/API tests (after implementation)
Ideas to improve test maintainability and coverage:
- **Selectors:** add and standardize `data-testid` attributes to reduce brittle selectors
- **Test data:** seed and clean up data via API (create users/lists/items via API, tear down after tests)
- **Isolation:** ensure every test is independent and doesn’t rely on previous tests
- **Structure:** use shared keyword resources / Page Object style keywords to reduce duplication
- **Negative paths:** expand coverage for invalid inputs and access control scenarios
- **Stability:** avoid sleeps; use explicit waits (`Wait For Elements State`, `Wait For Condition`)
- **CI diagnostics:** always upload Robot logs; optionally capture screenshots on failure

---

## Tools
### Manual testing
- Browser-based exploratory testing
- Bug reports written as markdown files

### Automated E2E tests
- **Robot Framework + Browser library (Playwright-based)**
- Base URL: `http://localhost` (configurable via `FRONTEND_URL` environment variable if needed)
- Tagging strategy:
  - `smoke` tag for quick checks on every push (merits)
  - Full suite executed nightly (merits)

### Automated API tests
- Robot Framework + RequestsLibrary (recommended for consistent tooling)
- Base URL: `http://localhost:4322` (docs at `/docs`)

### CI
- GitHub Actions workflows running on Ubuntu runners
- Docker Compose used to start application services in CI

---

## Test data strategy
- Use unique user accounts per test run (timestamp-based emails like `user-<epoch>@example.com`)
- Use unique list/item names per test to avoid collisions
- Tests are independent:
  - Each test creates the data it needs
  - Avoid relying on data created by previous tests
- If cleanup via UI is unreliable, rely on unique naming; future improvement is API-based teardown.

---

## Schedule
### Phase 1: Setup & planning
- Run app locally with Docker Compose
- Quick exploration of main features
- Draft and finalize this test plan

### Phase 2: Manual exploratory testing & bug reports
- Exploratory sessions per feature area (auth, lists, items, sharing)
- Write bug reports with clear reproduction steps
- Verify reproducibility after clean restart (`docker compose down -v` then up)

### Phase 3: Automated tests
- Implement E2E tests for user stories (pass)
- Implement API tests for endpoints (pass)
- Expand E2E to all user stories + add negative path; increase API to endpoints

### Phase 4: CI + stabilization + documentation
- GitHub Actions workflow for E2E tests
- Add API workflow, smoke vs nightly split, non-functional step
- Stabilize tests (fix selectors, add waits)
- Update README files for running E2E/API tests locally
- Build final zip and verify it overlays cleanly on a fresh clone

---

## Risks and mitigations
### Risk: Flaky UI tests due to unstable selectors or timing
Mitigation:
- Prefer stable selectors (`data-testid`) where possible
- Use explicit waits instead of sleep
- Keep tests focused and independent

### Risk: Test data collisions (same user/list names)
Mitigation:
- Use unique names/emails per test via timestamps
- Avoid shared state between tests

### Risk: CI environment differences / services not ready
Mitigation:
- Add “wait until service ready” step in GitHub Actions
- Upload Robot logs as artifacts to help debugging

### Risk: Failures due to real app faults
Mitigation:
- Document known faults in the E2E/API test README so peer reviewers know what to expect
- Avoid asserting behaviour that is clearly broken if it prevents meeting coverage requirements
