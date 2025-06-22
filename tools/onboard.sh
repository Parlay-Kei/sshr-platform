#!/bin/bash

set -e

echo "🚀 SSHR Platform Developer Onboarding"
echo "======================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "package.json" ] || [ ! -f "pnpm-workspace.yaml" ]; then
    print_error "Please run this script from the SSHR platform root directory"
    exit 1
fi

print_status "Starting developer onboarding..."

# Check Node.js version
print_status "Checking Node.js version..."
if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed. Please install Node.js 20+ first."
    print_status "Visit: https://nodejs.org/"
    exit 1
fi

NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 20 ]; then
    print_error "Node.js version 20+ is required. Current version: $(node --version)"
    exit 1
fi
print_success "Node.js version: $(node --version)"

# Install pnpm if not present
print_status "Checking pnpm installation..."
if ! command -v pnpm &> /dev/null; then
    print_status "Installing pnpm..."
    npm install -g pnpm
    print_success "pnpm installed successfully"
else
    print_success "pnpm already installed: $(pnpm --version)"
fi

# Install dependencies
print_status "Installing project dependencies..."
pnpm install
print_success "Dependencies installed successfully"

# Set up environment file
print_status "Setting up environment configuration..."
if [ ! -f "apps/web/.env" ]; then
    cat > apps/web/.env << EOF
# Database Configuration
DATABASE_URL=postgresql://username:password@localhost:5432/sshr_dev

# AWS Configuration
AWS_REGION=us-east-1
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key

# Stripe Configuration
STRIPE_SECRET=sk_test_your_stripe_secret_key
STRIPE_PUBLISHABLE_KEY=pk_test_your_stripe_publishable_key

# Application Configuration
NODE_ENV=development
PORT=3000
API_PORT=4000

# Security
JWT_SECRET=your_jwt_secret_key_here
COOKIE_SECRET=your_cookie_secret_here

# SMS Configuration (for patient reminders)
TWILIO_ACCOUNT_SID=your_twilio_account_sid
TWILIO_AUTH_TOKEN=your_twilio_auth_token
TWILIO_PHONE_NUMBER=+1234567890
EOF
    print_success "Environment file created at apps/web/.env"
    print_warning "Please update the environment variables with your actual values"
else
    print_success "Environment file already exists"
fi

# Install pre-commit hooks
print_status "Setting up pre-commit hooks..."
if command -v pre-commit &> /dev/null; then
    pre-commit install
    print_success "Pre-commit hooks installed"
else
    print_warning "pre-commit not found. Install with: pip install pre-commit"
fi

# Run initial checks
print_status "Running initial project checks..."

# Lint check
print_status "Running linter..."
if pnpm lint; then
    print_success "Linting passed"
else
    print_warning "Linting failed - please fix issues"
fi

# Test check
print_status "Running tests..."
if pnpm test; then
    print_success "Tests passed"
else
    print_warning "Tests failed - please fix issues"
fi

# Build check
print_status "Building project..."
if pnpm build; then
    print_success "Build successful"
else
    print_warning "Build failed - please fix issues"
fi

# Create development branch
print_status "Setting up development environment..."
if git branch --show-current | grep -q "master"; then
    git checkout -b develop
    print_success "Created and switched to develop branch"
else
    print_success "Already on development branch"
fi

# Final instructions
echo ""
echo "🎉 Onboarding Complete!"
echo "======================"
echo ""
echo "Next steps:"
echo "1. Update apps/web/.env with your actual configuration values"
echo "2. Start development server: pnpm dev"
echo "3. Visit: http://localhost:3000"
echo "4. Create feature branches: git checkout -b feature/your-feature"
echo ""
echo "Useful commands:"
echo "- pnpm dev          # Start development server"
echo "- pnpm lint         # Run linter"
echo "- pnpm test         # Run tests"
echo "- pnpm build        # Build for production"
echo "- pnpm format       # Format code"
echo ""
echo "Documentation:"
echo "- README.md         # Project overview and setup"
echo "- CONTRIBUTING.md   # Development guidelines"
echo "- .github/          # GitHub workflows and templates"
echo ""
print_success "Welcome to the SSHR Platform team! 🏥" 