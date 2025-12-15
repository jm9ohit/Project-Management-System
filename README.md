# Project Management System

A full-stack multi-tenant project management application built with Django, GraphQL, React, and TypeScript.

## 🚀 Features

### Backend
- **Multi-tenant Architecture**: Organization-based data isolation
- **GraphQL API**: Efficient data querying with Graphene-Django
- **RESTful Design**: Clean API architecture
- **PostgreSQL Database**: Robust data storage with proper indexing
- **Django Admin**: Easy data management interface

### Frontend
- **React 18 + TypeScript**: Type-safe component development
- **Apollo Client**: GraphQL client with caching and optimistic updates
- **TailwindCSS**: Modern, responsive UI design
- **Real-time Updates**: Automatic refetching and cache management
- **Task Management**: Kanban-style board with drag-and-drop potential

## 📋 Requirements

- Python 3.9+
- Node.js 16+
- PostgreSQL 12+
- npm or yarn

## 🛠️ Installation

### 1. Clone the Repository

```bash
git clone <repository-url>
cd project-management-system
```

### 2. Backend Setup

```bash
cd backend

# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Create .env file
cp .env.example .env
# Edit .env with your database credentials

# Create PostgreSQL database
createdb project_management

# Run migrations
python manage.py makemigrations
python manage.py migrate

# Create superuser (optional)
python manage.py createsuperuser

# Start development server
python manage.py runserver
```

The backend will be available at `http://localhost:8000`
- GraphQL endpoint: `http://localhost:8000/graphql/`
- Admin panel: `http://localhost:8000/admin/`

### 3. Frontend Setup

```bash
cd frontend

# Install dependencies
npm install

# Create .env file
cp .env.example .env

# Start development server
npm start
```

The frontend will be available at `http://localhost:3000`

## 🗄️ Database Setup

### Using Docker (Recommended)

```bash
docker run --name project-management-postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=project_management \
  -p 5432:5432 \
  -d postgres:14
```

### Using Local PostgreSQL

```bash
# Create database
createdb project_management

# Or using psql
psql -U postgres
CREATE DATABASE project_management;
\q
```

## 📚 API Documentation

### GraphQL Schema

The GraphQL API is self-documenting. Access the GraphiQL interface at `http://localhost:8000/graphql/` to explore:

- Available queries
- Available mutations
- Type definitions
- Field descriptions

### Key Queries

```graphql
# Get all projects for an organization
query {
  projects(organizationSlug: "my-org") {
    id
    name
    status
    taskCount
    completionRate
  }
}

# Get tasks for a project
query {
  tasks(projectId: "1", organizationSlug: "my-org") {
    id
    title
    status
    assigneeEmail
  }
}

# Get project statistics
query {
  projectStatistics(organizationSlug: "my-org") {
    totalProjects
    activeProjects
    completedProjects
    overallCompletionRate
  }
}
```

### Key Mutations

```graphql
# Create a project
mutation {
  createProject(
    organizationSlug: "my-org"
    name: "New Project"
    description: "Project description"
    status: "ACTIVE"
  ) {
    success
    errors
    project {
      id
      name
    }
  }
}

# Create a task
mutation {
  createTask(
    projectId: "1"
    organizationSlug: "my-org"
    title: "New Task"
    status: "TODO"
    assigneeEmail: "user@example.com"
  ) {
    success
    errors
    task {
      id
      title
    }
  }
}

# Add a comment
mutation {
  addTaskComment(
    taskId: "1"
    organizationSlug: "my-org"
    content: "Great work!"
    authorEmail: "commenter@example.com"
  ) {
    success
    errors
    comment {
      id
      content
    }
  }
}
```

## 🏗️ Architecture

### Backend Structure

```
backend/
├── project_management/     # Django project settings
│   ├── settings.py        # Configuration
│   ├── urls.py            # URL routing
│   └── wsgi.py           # WSGI configuration
├── core/                  # Main application
│   ├── models.py         # Data models
│   ├── schema.py         # GraphQL schema
│   ├── admin.py          # Admin configuration
│   ├── middleware.py     # Custom middleware
│   └── tests.py          # Test cases
└── manage.py             # Django management script
```

### Frontend Structure

```
frontend/
├── src/
│   ├── apollo/           # Apollo Client configuration
│   │   ├── client.ts    # Apollo setup
│   │   └── queries.ts   # GraphQL queries/mutations
│   ├── components/       # React components
│   │   ├── ProjectDashboard.tsx
│   │   ├── ProjectList.tsx
│   │   ├── TaskBoard.tsx
│   │   └── ...
│   ├── types/           # TypeScript type definitions
│   ├── App.tsx          # Root component
│   └── index.tsx        # Entry point
└── public/              # Static files
```

## 🔐 Multi-Tenancy

The system implements organization-based multi-tenancy:

1. **Organization Middleware**: Extracts organization context from headers
2. **Data Isolation**: All queries filtered by organization
3. **GraphQL Schema**: Organization slug required for all operations
4. **Frontend**: Organization selector in header

## ✅ Testing

### Backend Tests

```bash
cd backend
python manage.py test
```

### Frontend Tests

```bash
cd frontend
npm test
```

## 🎨 Design Decisions

### Technology Choices

1. **Django + GraphQL**: Chosen for rapid development and flexible querying
2. **PostgreSQL**: Robust relational database with excellent Django support
3. **Apollo Client**: Industry-standard GraphQL client with excellent caching
4. **TailwindCSS**: Utility-first CSS for rapid UI development
5. **TypeScript**: Type safety and better developer experience

### Trade-offs

1. **No Authentication**: Simplified for demo purposes; would add JWT/OAuth in production
2. **Email-based Assignment**: Simple approach; would use proper user models in production
3. **Optimistic Updates**: Implemented for better UX but adds complexity
4. **No Websockets**: Real-time updates via polling; would add subscriptions in production

## 🚀 Future Improvements

### High Priority
- User authentication and authorization
- Real-time updates with GraphQL subscriptions
- Drag-and-drop task reordering
- File attachments for tasks
- Email notifications
- Advanced filtering and search

### Medium Priority
- Task dependencies and subtasks
- Time tracking
- Project templates
- Bulk operations
- Export to CSV/PDF
- Activity log

### Nice to Have
- Mobile apps (React Native)
- Calendar view
- Gantt charts
- Integration with external services (Slack, Jira)
- AI-powered insights
- Custom fields and workflows

## 🐛 Known Issues

- Date picker formatting may vary by browser
- Long project/task names may overflow on small screens
- Optimistic updates may occasionally show stale data

## 📝 Development Notes

### Adding New Features

1. **Backend**: Add model → Create migration → Update schema → Add tests
2. **Frontend**: Add query/mutation → Create component → Add types → Test

### Database Migrations

```bash
# Create migration
python manage.py makemigrations

# Apply migration
python manage.py migrate

# Rollback migration
python manage.py migrate core <previous_migration_name>
```

## 📄 License

This project is created for demonstration purposes.

## 👥 Contributors

- jm_ohit

## 🙏 Acknowledgments

- Django and Django REST Framework teams
- GraphQL and Graphene-Python communities
- React and Apollo Client teams
- TailwindCSS team
