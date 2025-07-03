# Agent Instructions for Codex

This repository defines a full-stack .NET application designed to run inside the [`ghcr.io/openai/codex-universal`](https://github.com/openai/openai-codex) container.

## 💡 Purpose
The repository implements a whisky-tasting notes application with:
- A **Blazor frontend** (interactive UI in the browser)
- A **.NET Web API backend**
- **PostgreSQL** for persistent data storage

## 🔧 Container Environment

The Codex Universal container **does not ship with .NET or PostgreSQL installed** by default. These must be installed after cloning the repository using provided scripts.

### ⚙️ Required Setup Steps (after cloning):
```bash
./scripts/install_dotnet.sh
./scripts/install_and_mount_pg.sh
````

These scripts will:

* Install the required version of the .NET SDK (configured in the script)
* Install and start PostgreSQL with data storage mapped to a persistent host volume

## 🧠 Agent Capabilities

Once the environment is ready, the agent should be able to:

* Build and run the Blazor frontend and Web API
* Interact with PostgreSQL via Entity Framework or direct SQL
* Create and serve dynamic pages with routing, user login, image upload, and search
* Query and sort PostgreSQL data

Ensure PostgreSQL is running before launching the app.

## 🔒 Auth

User login is required to submit tasting notes unless using anonymous mode.

## 📦 Project Structure (expected)

```
.
├── scripts/
│   ├── install_dotnet.sh
│   └── install_and_mount_pg.sh
├── backend/       # ASP.NET Core Web API
├── frontend/      # Blazor WebAssembly or Server
├── pgdata/        # Host-mounted PostgreSQL data (optional)
├── README.md
└── agent.md
```
