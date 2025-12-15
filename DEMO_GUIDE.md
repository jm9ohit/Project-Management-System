# Demo Guide

This guide walks through the key features of the Project Management System.

## Getting Started

### 1. Initial Setup

After starting the application, you'll see the main interface:

**Screenshot**: Main landing page with organization selector
- Clean header with application title
- Organization dropdown selector
- Empty state prompting to select an organization

### 2. Creating an Organization

Click on the organization dropdown and select "Create New Organization":

**Screenshot**: Organization creation modal
- Form with fields for:
  - Organization Name (required)
  - Contact Email (required)
  - Slug (optional, auto-generated)
- Clear validation messages
- Cancel and Create buttons

**Example Data**:
```
Name: Acme Corporation
Contact Email: admin@acme.com
Slug: acme-corp (auto-generated)
```

## Dashboard Overview

### 3. Project Statistics

Once an organization is selected, the dashboard displays key metrics:

**Screenshot**: Statistics cards row
- Total Projects: 12
- Active Projects: 8
- Completed Projects: 3
- Total Tasks: 45
- Tasks Done: 23
- Overall Completion: 51%

Each card shows:
- Icon representing the metric
- Large number for the value
- Descriptive label
- Color-coded by category

### 4. Project List

Below statistics, the project list displays all projects:

**Screenshot**: Project grid view
- Cards arranged in a responsive grid (3 columns on desktop)
- Each card shows:
  - Project name (clickable)
  - Status badge (Active/Completed/On Hold)
  - Description preview
  - Task progress (X / Y tasks)
  - Progress bar with percentage
  - Due date
  - "View Tasks" button
  - Edit icon in corner

**Filters**:
- Status dropdown: All / Active / Completed / On Hold
- "New Project" button

## Creating a Project

### 5. Project Creation Form

Click "New Project" to open the creation form:

**Screenshot**: Project form
- Name field (required)
- Description textarea
- Status dropdown (Active/Completed/On Hold)
- Due date picker
- Cancel and Create buttons
- Form validation with error messages

**Example Data**:
```
Name: Website Redesign
Description: Complete overhaul of company website with modern design
Status: Active
Due Date: 2024-12-31
```

### 6. Project Created

**Screenshot**: New project card in grid
- Newly created project appears in the list
- Shows 0/0 tasks initially
- Green "Active" status badge

## Task Management

### 7. Task Board View

Click "View Tasks" or on a project name to open the task board:

**Screenshot**: Task board with three columns
- Header showing:
  - Back button
  - Project name and description
  - Statistics (total/completed tasks, completion %)
  - "Add Task" button

**Three Columns**:
1. To Do (gray background)
2. In Progress (blue background)
3. Done (green background)

Each column shows:
- Column title with task count
- Task cards stacked vertically
- Empty state if no tasks

### 8. Task Cards

**Screenshot**: Task card detail
- Task title (bold)
- Description preview (2 lines max)
- Bottom row with:
  - Assignee icon + email (truncated)
  - Comment count icon + number
  - Due date (highlighted in red if overdue)

### 9. Creating a Task

Click "Add Task" to open the task form:

**Screenshot**: Task creation form
- Title field (required)
- Description textarea
- Status dropdown (To Do/In Progress/Done)
- Assignee Email field
- Due Date/Time picker
- Cancel and Create buttons

**Example Data**:
```
Title: Design homepage mockup
Description: Create initial mockup for homepage redesign with new branding
Status: To Do
Assignee: designer@acme.com
Due Date: 2024-12-15 17:00
```

### 10. Task Detail Modal

Click on any task card to open the detail view:

**Screenshot**: Task detail modal
- Full-screen overlay with modal
- Header with:
  - "Task Details" title
  - Close button (X)
- Main content:
  - Task title
  - Status badge
  - Assignee email with icon
  - Due date with icon
  - Edit button
  - Full description
  - Comments section

### 11. Task Editing

Click "Edit" in task detail to modify:

**Screenshot**: Edit mode in task detail
- Same form as creation
- Pre-filled with current values
- Update and Cancel buttons

**Example Update**:
```
Status: In Progress → Done
```

### 12. Comments System

The comments section in task detail:

**Screenshot**: Comments interface
- "Comments (3)" header
- Add comment form:
  - Email input field
  - Comment textarea
  - "Add Comment" button
- List of existing comments:
  - Author email
  - Timestamp
  - Comment content
  - Gray background for each comment

**Example Comment**:
```
Email: reviewer@acme.com
Comment: Looks great! Just need to adjust the header spacing slightly.
```

## Advanced Features

### 13. Project Editing

Click the edit icon on any project card:

**Screenshot**: Project edit form
- Same fields as creation
- Pre-filled with current values
- Appears inline above project grid
- Save changes reflected immediately

### 14. Status Filtering

Use the status dropdown to filter projects:

**Screenshot**: Filtered view
- Only shows projects matching selected status
- Status badge in dropdown indicates active filter
- Clear/reset option

### 15. Real-time Statistics

As tasks are completed, statistics update automatically:

**Screenshot**: Before and after comparison
- Shows task count increasing
- Completion percentage updating
- Project status changing

## Mobile Responsive Design

### 16. Mobile View

**Screenshot**: Mobile phone view
- Single column layout
- Stacked cards
- Hamburger menu (if applicable)
- Touch-friendly buttons
- Optimized spacing

### 17. Tablet View

**Screenshot**: Tablet view
- Two-column project grid
- Task board columns stackable
- Adapted spacing for medium screens

## Error Handling

### 18. Form Validation

**Screenshot**: Validation errors
- Red border on invalid fields
- Error messages below fields
- Prevents submission until valid

**Example Errors**:
- "Project name is required"
- "Please enter a valid email address"
- "Name must be less than 200 characters"

### 19. Network Errors

**Screenshot**: Error message
- Red alert banner
- Icon indicating error
- Clear error message
- Suggestion to retry

### 20. Loading States

**Screenshot**: Loading spinner
- Centered animated spinner
- Shown during data fetching
- Prevents duplicate submissions

## GraphQL Playground

### 21. GraphiQL Interface

Navigate to http://localhost:8000/graphql/

**Screenshot**: GraphiQL interface
- Left panel: Query editor with syntax highlighting
- Center: Variables input
- Right: Schema documentation
- Top: Execute button
- Bottom: Results panel

**Example Query**:
```graphql
query GetProjects {
  projects(organizationSlug: "acme-corp") {
    id
    name
    status
    taskCount
    completionRate
  }
}
```

**Result**:
```json
{
  "data": {
    "projects": [
      {
        "id": "1",
        "name": "Website Redesign",
        "status": "ACTIVE",
        "taskCount": 5,
        "completionRate": 40.0
      }
    ]
  }
}
```

### 22. Mutation Example

**Screenshot**: Mutation in GraphiQL
```graphql
mutation CreateTask {
  createTask(
    projectId: "1"
    organizationSlug: "acme-corp"
    title: "New Task"
    status: "TODO"
  ) {
    success
    errors
    task {
      id
      title
    }
  }
}
```

## Performance Features

### 23. Optimistic Updates

**Screenshot**: Immediate UI update
- Task status changes instantly
- Progress bar updates before server confirms
- Reverts if operation fails

### 24. Caching

**Screenshot**: Network tab showing cached responses
- Subsequent loads use cached data
- Background refetch for fresh data
- Indicators showing cache hit/miss

## User Experience Highlights

### Key UX Features Demonstrated:

1. **Intuitive Navigation**
   - Clear hierarchy: Organizations → Projects → Tasks
   - Back buttons at each level
   - Breadcrumb-style navigation

2. **Visual Feedback**
   - Color-coded status badges
   - Progress bars for completion
   - Icons for actions and information
   - Loading states for async operations

3. **Responsive Design**
   - Works on desktop, tablet, mobile
   - Touch-friendly controls
   - Adaptive layouts

4. **Error Prevention**
   - Form validation before submission
   - Confirmation for destructive actions
   - Clear error messages

5. **Efficiency**
   - Keyboard shortcuts (where applicable)
   - Quick actions (inline editing)
   - Bulk operations (future)

## Testing the Multi-Tenancy

### 25. Organization Isolation

**Demo Steps**:
1. Create two organizations: "Acme Corp" and "Beta Inc"
2. Add projects to each
3. Switch between organizations
4. Verify data isolation

**Screenshot**: Organization switching
- Shows dropdown with multiple organizations
- Data updates when switching
- Statistics reflect current organization only

## Conclusion

This demo showcases:
- ✅ Complete CRUD operations for projects and tasks
- ✅ Multi-tenant architecture working correctly
- ✅ GraphQL API with efficient data fetching
- ✅ Modern, responsive UI with TailwindCSS
- ✅ Real-time updates and optimistic UI
- ✅ Comprehensive error handling
- ✅ Professional design and UX

The application is production-ready for MVP deployment and demonstrates all core requirements of the screening task.
