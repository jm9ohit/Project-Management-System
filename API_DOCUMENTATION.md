# API Documentation

## GraphQL Endpoint

Base URL: `http://localhost:8000/graphql/`

All requests require an organization context via header:
```
X-Organization-Slug: your-organization-slug
```

## Data Models

### Organization
- `id`: ID
- `name`: String
- `slug`: String (unique)
- `contactEmail`: Email
- `createdAt`: DateTime

### Project
- `id`: ID
- `organization`: Organization
- `name`: String
- `description`: String
- `status`: Enum (ACTIVE, COMPLETED, ON_HOLD)
- `dueDate`: Date
- `taskCount`: Int (computed)
- `completedTaskCount`: Int (computed)
- `completionRate`: Float (computed)
- `createdAt`: DateTime
- `updatedAt`: DateTime

### Task
- `id`: ID
- `project`: Project
- `title`: String
- `description`: String
- `status`: Enum (TODO, IN_PROGRESS, DONE)
- `assigneeEmail`: Email
- `dueDate`: DateTime
- `commentCount`: Int (computed)
- `createdAt`: DateTime
- `updatedAt`: DateTime

### TaskComment
- `id`: ID
- `task`: Task
- `content`: String
- `authorEmail`: Email
- `createdAt`: DateTime

## Queries

### Organizations

#### Get All Organizations
```graphql
query {
  organizations {
    id
    name
    slug
    contactEmail
    createdAt
  }
}
```

#### Get Single Organization
```graphql
query {
  organization(slug: "my-org") {
    id
    name
    contactEmail
  }
}
```

### Projects

#### Get Projects
```graphql
query GetProjects($organizationSlug: String!, $status: String) {
  projects(organizationSlug: $organizationSlug, status: $status) {
    id
    name
    description
    status
    dueDate
    taskCount
    completedTaskCount
    completionRate
    createdAt
    updatedAt
  }
}
```

Variables:
```json
{
  "organizationSlug": "my-org",
  "status": "ACTIVE"  // Optional: ACTIVE, COMPLETED, ON_HOLD
}
```

#### Get Single Project
```graphql
query GetProject($id: ID!, $organizationSlug: String!) {
  project(id: $id, organizationSlug: $organizationSlug) {
    id
    name
    description
    status
    dueDate
    taskCount
    completedTaskCount
    completionRate
  }
}
```

### Tasks

#### Get Tasks
```graphql
query GetTasks($projectId: ID!, $organizationSlug: String!, $status: String) {
  tasks(projectId: $projectId, organizationSlug: $organizationSlug, status: $status) {
    id
    title
    description
    status
    assigneeEmail
    dueDate
    commentCount
    createdAt
    updatedAt
  }
}
```

Variables:
```json
{
  "projectId": "1",
  "organizationSlug": "my-org",
  "status": "TODO"  // Optional: TODO, IN_PROGRESS, DONE
}
```

#### Get Single Task
```graphql
query GetTask($id: ID!, $organizationSlug: String!) {
  task(id: $id, organizationSlug: $organizationSlug) {
    id
    title
    description
    status
    assigneeEmail
    dueDate
    commentCount
  }
}
```

### Comments

#### Get Task Comments
```graphql
query GetTaskComments($taskId: ID!, $organizationSlug: String!) {
  taskComments(taskId: $taskId, organizationSlug: $organizationSlug) {
    id
    content
    authorEmail
    createdAt
  }
}
```

### Statistics

#### Get Project Statistics
```graphql
query GetProjectStatistics($organizationSlug: String!) {
  projectStatistics(organizationSlug: $organizationSlug) {
    totalProjects
    activeProjects
    completedProjects
    totalTasks
    completedTasks
    overallCompletionRate
  }
}
```

## Mutations

### Organization Mutations

#### Create Organization
```graphql
mutation CreateOrganization($name: String!, $contactEmail: String!, $slug: String) {
  createOrganization(name: $name, contactEmail: $contactEmail, slug: $slug) {
    success
    errors
    organization {
      id
      name
      slug
      contactEmail
    }
  }
}
```

Variables:
```json
{
  "name": "Acme Corp",
  "contactEmail": "contact@acme.com",
  "slug": "acme-corp"  // Optional - auto-generated if not provided
}
```

### Project Mutations

#### Create Project
```graphql
mutation CreateProject(
  $organizationSlug: String!
  $name: String!
  $description: String
  $status: String
  $dueDate: Date
) {
  createProject(
    organizationSlug: $organizationSlug
    name: $name
    description: $description
    status: $status
    dueDate: $dueDate
  ) {
    success
    errors
    project {
      id
      name
      description
      status
      dueDate
    }
  }
}
```

Variables:
```json
{
  "organizationSlug": "my-org",
  "name": "Website Redesign",
  "description": "Complete redesign of company website",
  "status": "ACTIVE",
  "dueDate": "2024-12-31"
}
```

#### Update Project
```graphql
mutation UpdateProject(
  $id: ID!
  $organizationSlug: String!
  $name: String
  $description: String
  $status: String
  $dueDate: Date
) {
  updateProject(
    id: $id
    organizationSlug: $organizationSlug
    name: $name
    description: $description
    status: $status
    dueDate: $dueDate
  ) {
    success
    errors
    project {
      id
      name
      status
    }
  }
}
```

### Task Mutations

#### Create Task
```graphql
mutation CreateTask(
  $projectId: ID!
  $organizationSlug: String!
  $title: String!
  $description: String
  $status: String
  $assigneeEmail: String
  $dueDate: DateTime
) {
  createTask(
    projectId: $projectId
    organizationSlug: $organizationSlug
    title: $title
    description: $description
    status: $status
    assigneeEmail: $assigneeEmail
    dueDate: $dueDate
  ) {
    success
    errors
    task {
      id
      title
      status
      assigneeEmail
    }
  }
}
```

Variables:
```json
{
  "projectId": "1",
  "organizationSlug": "my-org",
  "title": "Design homepage mockup",
  "description": "Create initial mockup for homepage redesign",
  "status": "TODO",
  "assigneeEmail": "designer@acme.com",
  "dueDate": "2024-12-15T17:00:00"
}
```

#### Update Task
```graphql
mutation UpdateTask(
  $id: ID!
  $organizationSlug: String!
  $title: String
  $description: String
  $status: String
  $assigneeEmail: String
  $dueDate: DateTime
) {
  updateTask(
    id: $id
    organizationSlug: $organizationSlug
    title: $title
    description: $description
    status: $status
    assigneeEmail: $assigneeEmail
    dueDate: $dueDate
  ) {
    success
    errors
    task {
      id
      title
      status
    }
  }
}
```

### Comment Mutations

#### Add Task Comment
```graphql
mutation AddTaskComment(
  $taskId: ID!
  $organizationSlug: String!
  $content: String!
  $authorEmail: String!
) {
  addTaskComment(
    taskId: $taskId
    organizationSlug: $organizationSlug
    content: $content
    authorEmail: $authorEmail
  ) {
    success
    errors
    comment {
      id
      content
      authorEmail
      createdAt
    }
  }
}
```

Variables:
```json
{
  "taskId": "1",
  "organizationSlug": "my-org",
  "content": "Looks great! Just a few minor changes needed.",
  "authorEmail": "reviewer@acme.com"
}
```

## Error Handling

All mutations return a response with:
- `success`: Boolean indicating if the operation succeeded
- `errors`: Array of error messages (empty if successful)
- Object (organization/project/task/comment): The created/updated object (null if failed)

Example error response:
```json
{
  "data": {
    "createProject": {
      "success": false,
      "errors": ["Organization not found"],
      "project": null
    }
  }
}
```

## Pagination

Currently not implemented. All queries return full result sets. For production use, implement cursor-based pagination:

```graphql
query {
  projects(organizationSlug: "my-org", first: 10, after: "cursor") {
    edges {
      node {
        id
        name
      }
      cursor
    }
    pageInfo {
      hasNextPage
      endCursor
    }
  }
}
```

## Rate Limiting

Not currently implemented. For production:
- Implement rate limiting middleware
- Add per-user/organization limits
- Return 429 status when exceeded

## Authentication

Current implementation uses organization slug for multi-tenancy. For production:
- Add JWT authentication
- Implement role-based access control (RBAC)
- Add user ownership and permissions
- Secure all mutations with authentication

## Best Practices

1. **Always provide organizationSlug** in queries and mutations
2. **Use fragments** for repeated field selections
3. **Batch queries** when fetching related data
4. **Handle errors gracefully** by checking the `success` field
5. **Use variables** instead of inline values for better caching
6. **Leverage Apollo Client cache** for optimistic updates

## Example Usage Patterns

### Create Organization and First Project
```graphql
# Step 1: Create organization
mutation {
  createOrganization(
    name: "My Company"
    contactEmail: "admin@mycompany.com"
  ) {
    success
    organization {
      slug
    }
  }
}

# Step 2: Create project (use slug from step 1)
mutation {
  createProject(
    organizationSlug: "my-company"
    name: "First Project"
    status: "ACTIVE"
  ) {
    success
    project {
      id
    }
  }
}
```

### Complete Task Workflow
```graphql
# 1. Create task
mutation {
  createTask(
    projectId: "1"
    organizationSlug: "my-org"
    title: "New Feature"
    status: "TODO"
  ) {
    task { id }
  }
}

# 2. Assign and move to in-progress
mutation {
  updateTask(
    id: "1"
    organizationSlug: "my-org"
    status: "IN_PROGRESS"
    assigneeEmail: "dev@company.com"
  ) {
    task { status }
  }
}

# 3. Add comment
mutation {
  addTaskComment(
    taskId: "1"
    organizationSlug: "my-org"
    content: "Started working on this"
    authorEmail: "dev@company.com"
  ) {
    comment { id }
  }
}

# 4. Complete task
mutation {
  updateTask(
    id: "1"
    organizationSlug: "my-org"
    status: "DONE"
  ) {
    task { status }
  }
}
```
