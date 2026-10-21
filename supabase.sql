create extension if not exists pgcrypto;
create table if not exists public.missed_questions (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 created_at timestamptz not null default now(),
 question_date date not null,
 section text not null check(section in ('Reading and Writing','Math')),
 skill text not null,
 topic text not null,
 college_board_question_id text,
 source text not null check(source in ('Bluebook','College Board Question Bank','Khan Academy','School / teacher','Other')),
 reason_wrong text not null check(reason_wrong in ('Did not know the concept','Misread the question','Careless mistake','Ran out of time','Used the wrong method','Guessed','Other')),
 correct_approach text,
 review_status text not null default 'Needs review' check(review_status in ('Needs review','Reviewed','Retest passed')),
 notes text,
 reviewed_at timestamptz
);
create index if not exists missed_questions_user_date_idx on public.missed_questions(user_id,question_date desc);
create index if not exists missed_questions_section_idx on public.missed_questions(user_id,section);
create index if not exists missed_questions_skill_idx on public.missed_questions(user_id,skill);
create index if not exists missed_questions_status_idx on public.missed_questions(user_id,review_status);
alter table public.missed_questions enable row level security;
drop policy if exists "Users can view their own missed questions" on public.missed_questions;
drop policy if exists "Users can insert their own missed questions" on public.missed_questions;
drop policy if exists "Users can update their own missed questions" on public.missed_questions;
drop policy if exists "Users can delete their own missed questions" on public.missed_questions;
create policy "Users can view their own missed questions" on public.missed_questions for select to authenticated using(auth.uid()=user_id);
create policy "Users can insert their own missed questions" on public.missed_questions for insert to authenticated with check(auth.uid()=user_id);
create policy "Users can update their own missed questions" on public.missed_questions for update to authenticated using(auth.uid()=user_id) with check(auth.uid()=user_id);
create policy "Users can delete their own missed questions" on public.missed_questions for delete to authenticated using(auth.uid()=user_id);
grant select,insert,update,delete on public.missed_questions to authenticated;
