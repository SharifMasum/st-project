# Register POST /api/auth/register

✅ happy: new user → 201/200

❌ negative: same user again → 409/400

# Login POST /api/auth/login

✅ happy: correct credentials → token returned

❌ negative: wrong password → 401/400

# Get lists GET /api/lists

✅ happy: with token → 200 + array

❌ negative: no token → 401/403

# Create list POST /api/lists

✅ happy: valid payload → 201/200 + id

❌ negative: missing name → 400

# Update list PUT /api/lists/{id}

✅ happy: change name/desc → 200

❌ negative: id not found → 404

# Delete list DELETE /api/lists/{id}

✅ happy: delete existing → 204/200

❌ negative: delete already deleted → 404

# Create todo item POST /api/lists/{id}/items (or similar)

✅ happy: add item → 201/200

❌ negative: empty title → 400