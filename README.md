# 💰 Expense Tracker

A simple and elegant **Expense Tracker** built with **Ruby on Rails 6**, designed to help users manage their daily expenses with ease.  
The project includes user authentication via **Devise**, a responsive **Bootstrap** interface, and complete **Docker** support.

---

## 🚀 Live Demo

🔗 [Expense Tracker on Render](https://expense-tracker-e8mg.onrender.com)

**Demo Credentials:**
- Email: `you@example.com` | Password: `password123`  
- Email: `friend@example.com` | Password: `password123`

---

## 🧩 Tech Stack

- **Ruby:** ~> 3.0  
- **Rails:** ~> 6.1.4  
- **Database:** SQLite (development/test), PostgreSQL (production)  
- **Frontend:** Bootstrap 4.6, jQuery, Slim, Webpacker  
- **Authentication:** Devise  
- **Containerization:** Docker  
- **Package Manager:** Yarn  

---

## ⚙️ Prerequisites

Before starting, make sure your system has the following installed:

---

### 🪟 On **Windows (using WSL 2)**

1. Enable **WSL 2** and install **Ubuntu** from the Microsoft Store.  
2. Inside WSL, install dependencies:

   ```bash
   sudo apt update
   sudo apt install -y curl gnupg2 build-essential libssl-dev libreadline-dev zlib1g-dev sqlite3 libsqlite3-dev nodejs yarn git
   ```

3. Install Ruby using a version manager like **rbenv**:

   ```bash
   curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-installer | bash
   exec $SHELL
   rbenv install 3.0.0
   rbenv global 3.0.0
   ruby -v
   ```

4. Install Rails:

   ```bash
   gem install rails -v 6.1.4
   rails -v
   ```

5. Verify Yarn:

   ```bash
   yarn -v
   ```

---

### 🐧 On **Linux (Ubuntu/Debian)**

1. Install dependencies:

   ```bash
   sudo apt update
   sudo apt install -y curl gnupg2 build-essential libssl-dev libreadline-dev zlib1g-dev sqlite3 libsqlite3-dev nodejs yarn git
   ```

2. Install Ruby via **rbenv**:

   ```bash
   curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-installer | bash
   exec $SHELL
   rbenv install 3.0.0
   rbenv global 3.0.0
   ruby -v
   ```

3. Install Rails:

   ```bash
   gem install rails -v 6.1.4
   ```

4. Verify installations:

   ```bash
   ruby -v
   rails -v
   yarn -v
   sqlite3 --version
   ```

---

### 🍎 On **macOS**

1. Install **Homebrew** (if not installed):

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. Install dependencies:

   ```bash
   brew install ruby rails yarn sqlite3 git
   ```

3. Verify installations:

   ```bash
   ruby -v
   rails -v
   yarn -v
   ```

---

## 🧠 Project Setup

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/Commutatus-Interviews/shubhang-shukla.git
cd shubhang-shukla
```

### 2️⃣ Install Dependencies

```bash
bundle install
yarn install
```

### 3️⃣ Setup the Database

```bash
rails db:create db:migrate db:seed
```

### 4️⃣ Run the Server

```bash
rails s
```

App will be available at 👉 [http://localhost:3000](http://localhost:3000)

---

## 🐳 Docker Setup (Optional)

If you prefer to run the project using **Docker** instead of setting up Ruby/Rails manually:

### 1. Build the Docker image

```bash
docker build -t expense-tracker .
```

### 2. Run the container

```bash
docker run -p 3000:3000 expense-tracker
```

App will be available at 👉 [http://localhost:3000](http://localhost:3000)

---


