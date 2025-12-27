*** Variables ***
# Login page (confirmed)
${LOGIN_USERNAME}          css=input[name="username"]
${LOGIN_PASSWORD}          css=input[name="password"]
${BTN_LOGIN}               css=button:has-text("Login")
${BTN_TO_REGISTRATION}     css=button:has-text("To Registration")
${LINK_REGISTER}           css=a[href="/register"]

# Register page
${REG_USERNAME}            css=input[name="username"]
${REG_PASSWORD}            css=input[name="password"]
${REG_PASSWORD2}           css=input[name="passwordConfirmation"]
${BTN_REGISTER}            css=button:has-text("Register")

# Logged in
${LINK_LOGOUT}             css=a[href="/login"]:has-text("Logout")

${BTN_NEW_TODO_LIST}       css=button:has-text("New todo list")
${FIELD_LIST_NAME}         css=input#name
${FIELD_LIST_DESC}         css=textarea#description
${BTN_CREATE_LIST}         css=:has(#name) button:has-text("Create")

