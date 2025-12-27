# [Bug] Sharing the same todo list with the same user gives no feedback or warning

## Environment
- URL: http://localhost/
- Run mode: docker compose up (default configuration)
- Browser: Chrome
- OS: Windows

## Severity
Major

## Steps to reproduce
1. Open http://localhost/
2. Register and log in as a user (Owner)
3. Create a new todo list
4. Share the list with another registered user
5. Attempt to share the same list again with the same user

## Expected result
The application should either:
- Prevent duplicate sharing and show a clear message, or
- Indicate that the list is already shared with the selected user

## Actual result
No feedback or warning is shown, and it is unclear whether the action succeeded or failed.

## Reproducibility
Always (reproduced multiple times, including after restarting the application)

## Notes
This causes user confusion, as the UI provides no indication of the system state.
