# Quick Start Guide

Get the Project Management System running in 5 minutes!

## Prerequisites Check

```bash
# Check Python version (need 3.9+)
python --version

# Check Node version (need 16+)
node --version

# Check PostgreSQL (need 12+)
psql --version

# Check npm
npm --version
```

## Option 1: Docker Setup (Easiest)

```bash
# Clone the repository
git clone <repository-url>
cd project-management-system

# Start everything with Docker
docker-compose up --build

# Wait for services to start...
# Backend: http://localhost:8000
# Frontend: http://localhost:3000
# GraphQL: http://localhost:8000/graphql/
```

That's it! Skip to "First Steps" below.

## Option 2: Manual Setup

### Step 1: Database Setup

```bash
# Start PostgreSQL (if not running)
# On macOS:
brew services start postgresql

# On Linux:
sudo systemctl start postgresql

# Create database
createdb project_management

# Or using psql:
psql -U postgres
CREATE DATABASE project_management;
\q
```

### Step 2: Backend Setup

```bash
cd backend

# Create virtual environment
python -m venv venv

# Activate it
# On macOS/Linux:
source venv/bin/activate
# On Windows:
venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Create .env file
cp .env.example .env

# Edit .env with your database credentials
# (or use defaults if you followed database setup above)

# Run migrations
python manage.py makemigrations
python manage.py migrate

# Create superuser (optional)
python manage.py createsuperuser

# Start server
python manage.py runserver
```

Backend is now running at http://localhost:8000

### Step 3: Frontend Setup

Open a new terminal:

```bash
cd frontend

# Install dependencies
npm install

# Create .env file
cp .env.example .env

# Start development server
npm start
```

Frontend is now running at http://localhost:3000

## First Steps

### 1. Open the Application
Navigate to http://localhost:3000 in your browser

### 2. Create an Organization
- Click on the organization dropdown
- Select "+ Create New Organization"
- Fill in:
  - Name: "My Company"
  - Email: "admin@mycompany.com"
- Click "Create"

### 3. Create Your First Project
- Click "New Project"
- Fill in:
  - Name: "Sample Project"
  - Description: "My first project"
  - Status: "Active"
- Click "Create Project"

### 4. Add Tasks
- Click "View Tasks" on your project
- Click "Add Task"
- Fill in:
  - Title: "First Task"
  - Status: "To Do"
  - Assignee: "user@mycompany.com"
- Click "Create Task"

### 5. Explore Features
- Click on tasks to view details and add comments
- Edit projects and tasks
- Move tasks between status columns
- View project statistics

## Troubleshooting

### Database Connection Error
```
Error: could not connect to database
```
**Solution**: Check PostgreSQL is running and credentials in `.env` are correct

### Port Already in Use
```
Error: Port 8000 is already in use
```
**Solution**: 
```bash
# Find and kill process using port
# On macOS/Linux:
lsof -ti:8000 | xargs kill -9

# On Windows:
netstat -ano | findstr :8000
taskkill /PID <PID> /F
```

### Module Not Found
```
ModuleNotFoundError: No module named 'graphene_django'
```
**Solution**: Make sure virtual environment is activated and dependencies installed
```bash
source venv/bin/activate  # or venv\Scripts\activate on Windows
pip install -r requirements.txt
```

### Node Modules Error
```
Error: Cannot find module 'react'
```
**Solution**: Reinstall dependencies
```bash
rm -rf node_modules package-lock.json
npm install
```

### Migration Error
```
django.db.migrations.exceptions.InconsistentMigrationHistory
```
**Solution**: Reset migrations
```bash
python manage.py migrate --fake core zero
python manage.py migrate
```

### CORS Error in Browser
```
Access to XMLHttpRequest blocked by CORS policy
```
**Solution**: Check backend is running and CORS settings in `settings.py` include frontend URL

## Useful Commands

### Backend

```bash
# Create migrations
python manage.py makemigrations

# Apply migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser

# Run tests
python manage.py test

# Access Django shell
python manage.py shell

# Access database shell
python manage.py dbshell
```

### Frontend

```bash
# Start development server
npm start

# Run tests
npm test

# Build for production
npm run build

# Check for lint errors
npm run lint
```

### Docker

```bash
# Start all services
docker-compose up

# Start in background
docker-compose up -d

# Stop all services
docker-compose down

# View logs
docker-compose logs -f

# Rebuild containers
docker-compose up --build

# Run backend command
docker-compose exec backend python manage.py migrate

# Access backend shell
docker-compose exec backend python manage.py shell
```

## API Testing

### Using GraphiQL (Browser)
1. Navigate to http://localhost:8000/graphql/
2. Try this query:
```graphql
query {
  organizations {
    id
    name
    slug
  }
}
```

### Using cURL
```bash
curl -X POST http://localhost:8000/graphql/ \
  -H "Content-Type: application/json" \
  -H "X-Organization-Slug: my-company" \
  -d '{"query": "{ projects(organizationSlug: \"my-company\") { id name } }"}'
```

### Using Postman
1. Create new request
2. Method: POST
3. URL: http://localhost:8000/graphql/
4. Headers:
   - Content-Type: application/json
   - X-Organization-Slug: my-company
5. Body (GraphQL):
```graphql
query {
  projects(organizationSlug: "my-company") {
    id
    name
  }
}
```

## Next Steps

- Read [API_DOCUMENTATION.md](API_DOCUMENTATION.md) for complete API reference
- Read [TECHNICAL_SUMMARY.md](TECHNICAL_SUMMARY.md) for architecture details
- Read [DEMO_GUIDE.md](DEMO_GUIDE.md) for feature walkthrough
- Check [README.md](README.md) for comprehensive documentation

## Getting Help

1. Check the logs:
   - Backend: Terminal running `python manage.py runserver`
   - Frontend: Terminal running `npm start`
   - Browser console: F12 → Console tab

2. Common issues:
   - Backend not running → Check terminal for errors
   - Database issues → Verify PostgreSQL is running
   - Frontend errors → Check browser console
   - CORS errors → Verify backend CORS settings

3. Reset everything:
```bash
# Stop all services
# Drop database
dropdb project_management
createdb project_management

# Backend
cd backend
python manage.py migrate
python manage.py runserver

# Frontend
cd frontend
rm -rf node_modules
npm install
npm start
```

## Success!

You should now have:
- ✅ Backend running on http://localhost:8000
- ✅ Frontend running on http://localhost:3000
- ✅ GraphQL playground at http://localhost:8000/graphql/
- ✅ An organization created
- ✅ Sample project with tasks

Happy project managing! 🚀
