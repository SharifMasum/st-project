# [Bug] Viewer permission shows edit option but editing is not allowed

## Environment
- URL: http://localhost/
- Run mode: docker compose up (default configuration)
- Browser: Chrome
- OS: Windows

## Severity
Medium

## Steps to reproduce
1. Register two users (Owner and Viewer)
2. Log in as Owner
3. Create a todo list
4. Share the list with the Viewer user using viewer permissions
5. Log out
6. Log in as Viewer
7. Open the shared todo list
8. Observe that edit options are visible
9. Attempt to edit the list or a todo item

## Expected result
Either:
- The Viewer should not see edit options at all, or
- The Viewer should be able to successfully edit if the option is shown

## Actual result
Edit options are visible, but attempting to edit results in an error message stating that the user does not have permission.

## Reproducibility
Always (reproduced consistently)

## Notes
Displaying unavailable actions creates confusion and misleading UI behavior.
