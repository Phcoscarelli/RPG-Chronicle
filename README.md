# Chronicle

> The world of your RPG, outside the session.

Chronicle is a platform designed to help Game Masters and players organize, explore, and preserve the world created during tabletop RPG campaigns.

Instead of keeping important information scattered across notes, messages, documents, and memory, Chronicle brings characters, campaigns, lore, and events together in one organized space.

The goal is simple: **make it easy to find the right information when you need it.**

---

## About the Project

Tabletop RPG campaigns can generate a huge amount of information over time:

- Characters and NPCs
- Places and cities
- Important events
- Campaign history
- Player characters
- Session summaries
- World lore

As a campaign grows, remembering everything becomes increasingly difficult.

Chronicle was created to solve this problem by providing a dedicated space where the campaign's world can be documented and explored.

> Chronicle is not a VTT and will never be a combat simulator.
>
> Its purpose is to be the **world of the RPG outside the session**.

---

## Features

### Campaign Management

- Create and manage multiple campaigns
- Define the RPG system used by the campaign
- Add a campaign description
- Optional campaign cover image
- Manage campaign members
- Support multiple Game Masters
- Define roles and permissions

### Campaign Members

Chronicle supports different roles within a campaign:

- `OWNER`
- `GAME_MASTER`
- `PLAYER`
- `OBSERVER`

Users can participate in multiple campaigns with different roles.

### Player Characters

Players can create characters within a campaign, including:

- Name
- Race
- Class
- Personality
- Appearance
- Backstory
- Portrait
- Character status

Character statuses include:

- `ALIVE`
- `DEAD`
- `RETIRED`
- `MISSING`

Characters remain part of the campaign even after they are no longer active, preserving the campaign's history.

### Campaign Documentation

Chronicle is designed around the idea of a campaign wiki and timeline.

The platform aims to make information such as characters, locations, events, and campaign history quickly searchable and accessible.

### Session History

Chronicle will provide tools for documenting campaign sessions, including:

- Official session summaries
- Player-written perspectives
- Character thoughts and feelings
- Important events

This allows the campaign to preserve not only what happened, but also how different characters experienced it.

---

## Tech Stack

### Backend

- **TypeScript**
- **Node.js**
- **NestJS**
- **Prisma**
- **PostgreSQL**
- **REST API**

### Infrastructure & Development

- **Docker**
- **Docker Compose**
- **Git**
- **GitHub**

---

## Architecture

The project is organized into separate backend and frontend applications:

```text
Chronicle/
├── backend/
│   ├── src/
│   ├── prisma/
│   └── ...
│
├── frontend/
│   └── ...
│
├── docs/
│   └── ...
│
└── docker-compose.yml
