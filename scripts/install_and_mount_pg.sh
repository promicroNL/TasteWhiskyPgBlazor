#!/bin/bash

set -e

PG_VERSION=16
PG_USER=postgres
PG_DATA_DIR="./pgdata"
PG_INTERNAL_DIR="/etc/postgresql/$PG_VERSION/main"
PG_LOG_FILE="/tmp/postgresql.log"

DB_NAME="postgresTest"
DB_PASSWORD="postgres"
NEW_USER="devuser"
NEW_PASS="devpass"

echo "🔄 Updating apt packages..."
sudo apt-get update

echo "📦 Installing PostgreSQL..."
sudo apt-get install -y postgresql

echo "📁 Preparing data directory..."
sudo mkdir -p "$PG_DATA_DIR"
sudo chown -R $PG_USER:$PG_USER "$PG_DATA_DIR"

# Only initialize if PG_VERSION file is missing
if [ ! -f "$PG_DATA_DIR/PG_VERSION" ]; then
    echo "🚧 No existing data found — initializing cluster..."
    sudo -u $PG_USER /usr/lib/postgresql/$PG_VERSION/bin/initdb -D "$PG_DATA_DIR"
else
    echo "✅ Existing data directory found, skipping init."
fi

echo "🔗 Linking configuration to use mounted data directory..."
# Copy the configuration from original to new location (only if not already linked)
if [ ! -f "$PG_DATA_DIR/postgresql.conf" ]; then
    sudo cp "$PG_INTERNAL_DIR"/*.conf "$PG_DATA_DIR/"
    sudo cp -r "$PG_INTERNAL_DIR"/conf.d "$PG_DATA_DIR/" || true
fi

# Start PostgreSQL with new data directory
echo "🚀 Starting PostgreSQL..."
sudo -u $PG_USER /usr/lib/postgresql/$PG_VERSION/bin/pg_ctl \
    -D "$PG_DATA_DIR" \
    -l "$PG_LOG_FILE" \
    -o "-c config_file=$PG_DATA_DIR/postgresql.conf" \
    start

# Wait for PostgreSQL to become ready
echo "⏳ Waiting for PostgreSQL to respond..."
until sudo -u $PG_USER pg_isready -d postgres; do
  sleep 1
done

# Only run DB creation if this is a new cluster (based on a marker file)
INIT_MARKER="$PG_DATA_DIR/.initialized"

if [ ! -f "$INIT_MARKER" ]; then
    echo "🔐 Setting password for user '$PG_USER'..."
    sudo -u $PG_USER psql -c "ALTER USER $PG_USER WITH PASSWORD '$DB_PASSWORD';"

    echo "🗃️ Creating database '$DB_NAME'..."
    sudo -u $PG_USER psql -c "CREATE DATABASE \"$DB_NAME\";"

    echo "👤 Creating user '$NEW_USER'..."
    sudo -u $PG_USER psql -c "CREATE USER $NEW_USER WITH PASSWORD '$NEW_PASS';"

    echo "🛡️ Granting privileges..."
    sudo -u $PG_USER psql -c "GRANT ALL PRIVILEGES ON DATABASE \"$DB_NAME\" TO $NEW_USER;"

    echo "📦 Creating and populating a test table..."
    sudo -u $PG_USER psql -d "$DB_NAME" -c "CREATE TABLE test_table (id SERIAL PRIMARY KEY, name TEXT);"
    sudo -u $PG_USER psql -d "$DB_NAME" -c "INSERT INTO test_table (name) VALUES ('hello'), ('world');"

    touch "$INIT_MARKER"
    echo "📝 Initialization complete and marker file created."
else
    echo "🧠 Initialization already performed — skipping DB/user creation."
fi

echo "✅ PostgreSQL is up and running using external data directory: $PG_DATA_DIR"
