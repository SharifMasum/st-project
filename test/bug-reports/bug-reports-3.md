# [Bug] Non-owner user can be assigned ownership of a todo list

## Environment
- URL: http://localhost/
- Run mode: docker compose up (default configuration)
- Browser: Chrome
- OS: Windows

## Severity
Major

## Steps to reproduce
1. Register two users (User A and User B)
2. Log in as User A
3. Create a new todo list
4. Share the list with User B
5. Assign User B as the owner of the list

## Expected result
Only the creator of the list should retain ownership, or ownership transfer should be clearly restricted and controlled.

## Actual result
The application allows assigning ownership to a user who did not create the list.

## Reproducibility
Always

## Notes
This may lead to authorization and responsibility issues and appears to violate expected ownership logic.
