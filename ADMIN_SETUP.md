# Admin System Setup Guide

## Overview
This system uses Supabase to manage admin users with role-based access control.

## Database Setup

### 1. Run the Migration
Execute the SQL migration file in your Supabase SQL Editor:
```bash
supabase/migrations/001_create_profiles.sql
```

This creates:
- `profiles` table with user roles
- Row Level Security (RLS) policies
- Automatic profile creation trigger
- Admin promotion function

## How to Promote a User to Admin

### Option 1: Using Supabase SQL Editor (Recommended)
1. Go to your Supabase Dashboard → SQL Editor
2. Run this query:
```sql
SELECT promote_to_admin('user@example.com');
```

### Option 2: Using Supabase CLI
```bash
npx supabase db execute "SELECT promote_to_admin('user@example.com');"
```

### Option 3: Manually Update (Direct SQL)
```sql
UPDATE public.profiles
SET role = 'admin', updated_at = NOW()
WHERE email = 'user@example.com';
```

## System Components

### 1. Middleware (`app/middleware/admin.ts`)
- Protects admin routes
- Checks user authentication
- Verifies admin role
- Redirects non-admins to dashboard

### 2. Composable (`app/composables/useUserProfile.ts`)
- Fetches user profile data
- Provides `isAdmin` computed property
- Handles profile updates
- Client-side role checking

### 3. Login Flow (`app/pages/login.vue`)
- Authenticates user
- Fetches profile role
- Redirects based on role:
  - Admin → `/admin`
  - Regular user → `/dashboard`

### 4. Admin Page (`app/pages/admin.vue`)
- Protected by admin middleware
- Displays admin dashboard
- Shows all users
- Stats and analytics

## Security Features

### Row Level Security (RLS)
- Users can only view/update their own profiles
- Users CANNOT change their own role
- Only admins can view all profiles
- Role changes require service_role key (server-side only)

### Policies
1. **View Own Profile**: Users can see their own data
2. **Update Own Profile**: Users can update (except role)
3. **Admin View All**: Admins can see all profiles
4. **No Client-Side Role Changes**: Role field is protected

## Testing the System

### 1. Create a Test User
```bash
# Sign up through the app or create in Supabase
```

### 2. Promote to Admin
```sql
SELECT promote_to_admin('test@example.com');
```

### 3. Login and Verify
- Login with the promoted user
- Should redirect to `/admin`
- Should see admin dashboard
- Can view all users

### 4. Test Non-Admin
- Login with regular user
- Should redirect to `/dashboard`
- Cannot access `/admin` (middleware redirects)

## Environment Variables
Make sure your `.env` file has:
```env
SUPABASE_URL=your-project-url
SUPABASE_KEY=your-anon-key
```

## Routes Configuration
Admin routes are excluded from automatic auth redirects in `nuxt.config.ts`:
```typescript
supabase: {
  redirectOptions: {
    exclude: ['/admin', ...]
  }
}
```

## Important Notes

⚠️ **Security**:
- Never expose service_role key to client
- Role changes must be server-side only
- RLS policies prevent client-side role manipulation

✅ **Best Practices**:
- Always use the `promote_to_admin()` function
- Test with multiple user roles
- Monitor admin activity
- Keep admin list minimal

## Troubleshooting

### User Not Redirecting to Admin
1. Check if user is actually admin: `SELECT * FROM profiles WHERE email = 'user@example.com'`
2. Clear browser cache and cookies
3. Check browser console for errors

### Can't Access Admin Page
1. Verify middleware is applied: `definePageMeta({ middleware: 'admin' })`
2. Check user authentication state
3. Verify profile exists in database

### Profile Not Created
1. Check if trigger is active: `\df handle_new_user` in SQL Editor
2. Verify auth.users table has the user
3. Manually insert profile if needed

## Next Steps

### Recommended Enhancements:
1. Add audit logging for admin actions
2. Implement more granular permissions
3. Add admin activity dashboard
4. Create admin notification system
5. Add bulk user management tools
