-- Contact Requests Table for Contact Form
create table if not exists contact_requests (
  id uuid primary key default gen_random_uuid(),
  created_at timestamp with time zone default now(),
  first_name text not null,
  last_name text not null,
  email text not null,
  phone text,
  subject text not null,
  budget text,
  deadline date,
  message text not null,
  attachments jsonb, -- array of file URLs/metadata
  newsletter boolean default false,
  consent boolean default false
);
