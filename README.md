# TasteWhiskyPgBlazor 🥃 the Whisky Tasting Notes App

A full-stack .NET application for whisky lovers to log, share, and rate tasting notes.

## 🔧 Tech Stack

- **Frontend**: Blazor (WebAssembly or Server)
- **Backend**: .NET Web API
- **Database**: PostgreSQL (host-mounted and persistent)
- **Container**: [`ghcr.io/openai/codex-universal`](https://github.com/openai/openai-codex)

---

## 🚀 Features

- 🔐 User login with optional anonymous mode
- 🥃 Select drams by:
  - Distillery
  - Age
  - Special bottling (if applicable)
- ✍️ Fill in tasting notes with:
  - Nose
  - Palate
  - Finish
  - Score
  - Overall impression
- 📸 Upload or take a photo of the dram or tasting setup
- 🔎 View and search all notes by:
  - Distillery
  - Rating
  - Taster
  - Age
- 📈 Leaderboard showing highest-rated drams
- ⭐ Rate other users' tasting notes

---

## ⚙️ Setup

### 🐳 Inside Codex Container

> 🛑 `dotnet` and `postgresql` are **not included by default** in the container.
> You must run the following scripts after cloning:

```bash
./scripts/install_dotnet.sh
./scripts/install_and_mount_pg.sh
````

* `install_dotnet.sh`: installs the required .NET SDK (8.x)
* `install_and_mount_pg.sh`: installs PostgreSQL and mounts persistent data to `./pgdata`

Make sure the PostgreSQL service is up before running the app.

---

## 📁 Folder Structure

```
.
├── frontend/            # Blazor frontend
├── backend/             # Web API (ASP.NET Core)
├── pgdata/              # Optional host-mounted PostgreSQL data
├── scripts/
│   ├── install_dotnet.sh
│   └── install_and_mount_pg.sh
├── README.md
└── agent.md
```

---

## 🛠 Development Workflow

1. Clone the repo:

   ```bash
   git clone <this-repo>
   cd <this-repo>
   ```

2. Start your Codex container:

   ```bash
   docker run --rm -it \
     -e CODEX_ENV_DOTNET_VERSION=8.0.2 \
     -v "${PWD}:/workspace/$(basename $PWD)" \
     -w "/workspace/$(basename $PWD)" \
     ghcr.io/openai/codex-universal:latest
   ```

3. Inside the container:

   ```bash
   ./scripts/install_dotnet.sh
   ./scripts/install_and_mount_pg.sh
   ```

4. Run the backend and frontend (instructions will be specific per implementation)

---

## 🧠 Future Ideas

* Add image moderation or tagging with AI
* Email notifications for popular notes
* Distillery profile pages
* Mobile PWA support

---

## 🥃 Slàinte Mhath!

Celebrate whisky, community, and craft.
