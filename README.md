# 📚 ReadCoin

**Read. Earn. Spend.** — kids read real books, pass a comprehension quiz, and earn coins
they spend on rewards their parents define (movie night, a zoo trip, a LEGO set).

This is the 2026 full rewrite of the original 2018 Rails 5.2 app: Rails 8, Hotwire,
Tailwind, SQLite, and AI-generated quizzes via the Claude API. No payment processing —
rewards are real-world promises from parents, not purchases.

## How it works

- **Parents** sign up, add their kids (each kid gets an avatar and a 4-digit PIN), curate
  a bookshelf (link to free books on Project Gutenberg / StoryWeaver), and define rewards.
- **Kids** log in on a tablet at `/play` with their PIN — no email or password. They read
  a book, take a 5-question quiz, and earn coins for scoring 80%+. Daily reading builds a
  streak. Coins are spent in the prize shop; parents approve redemptions.
- **Quizzes** are graded server-side (answers never reach the browser) and can be
  generated with Claude: set `ANTHROPIC_API_KEY` and hit “Generate quiz with AI” on any book.

## Stack

Ruby 3.3 · Rails 8.1 · SQLite (Solid Queue/Cache/Cable) · Hotwire · Tailwind CSS 4 ·
Propshaft + import maps · `anthropic` gem for quiz generation.

## Getting started

```sh
bundle install
bin/rails db:prepare db:seed
bin/dev
```

Seeds create a demo family: parent `demo@readcoin.app` / `password123`,
kids **Leo** (PIN `1234`) and **Maya** (PIN `5678`), four public-domain books, and three rewards.

Optional: `export ANTHROPIC_API_KEY=sk-ant-...` to enable AI quiz generation.

## Tests

```sh
bin/rails test
```
