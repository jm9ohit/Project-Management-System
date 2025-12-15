#!/bin/bash

echo "🚀 Project Management System - Quick Setup"
echo "=========================================="

# Check if Docker is available
if command -v docker &> /dev/null; then
    echo "✓ Docker detected"
    echo ""
    echo "Starting with Docker..."
    docker-compose up --build
else
    echo "Docker not found. Using manual setup..."
    echo ""
    
    # Backend setup
    echo "📦 Setting up backend..."
    cd backend
    
    # Create virtual environment
    python3 -m venv venv
    source venv/bin/activate || . venv/Scripts/activate
    
    # Install dependencies
    pip install -r requirements.txt
    
    # Copy env file
    cp .env.example .env
    
    echo "Please configure your database in backend/.env"
    echo "Then run:"
    echo "  python manage.py migrate"
    echo "  python manage.py runserver"
    echo ""
    
    # Frontend setup
    echo "📦 Setting up frontend..."
    cd ../frontend
    
    # Install dependencies
    npm install
    
    # Copy env file
    cp .env.example .env
    
    echo ""
    echo "To start the frontend, run:"
    echo "  npm start"
    echo ""
    echo "✅ Setup complete!"
    echo "Backend: http://localhost:8000"
    echo "Frontend: http://localhost:3000"
    echo "GraphQL: http://localhost:8000/graphql/"
fi
