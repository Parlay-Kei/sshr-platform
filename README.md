# SSHR Platform

A four-phase digital stack that drags small clinics out of paper purgatory.

[![CI](https://github.com/Parlay-Kei/sshr-platform/actions/workflows/ci.yml/badge.svg)](https://github.com/Parlay-Kei/sshr-platform/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 🏥 Why it exists
Patients lose time; staff drown in clipboards; revenue leaks through denial cycles. \
SSHR stitches those gaps with:

1. **E-forms + SMS reminders** (≤30 days)
2. **Cloud EHR + chart scanning** (≤90 days)
3. **Automated eligibility + clean-claim RCM** (≤120 days)
4. **BI dashboards for visits, denials, no-shows** (≤150 days)

## 🏗️ Architecture

```mermaid
flowchart LR
  subgraph Front End
    FE[React 19]
  end
  subgraph API
    API[NestJS]
  end
  subgraph Data
    DB[(PostgreSQL RDS)]
    S3[(Scanned Charts)]
  end
  FE --REST+GraphQL--> API
  API --ORM--> DB
  API --S3 SDK--> S3
  API --Webhook--> Stripe
```

## 🚀 Quick Start

### Prerequisites
- Node.js 20+
- pnpm 10+
- Git

### Installation

```bash
# Clone the repository
git clone https://github.com/Parlay-Kei/sshr-platform.git
cd sshr-platform

# Install dependencies
pnpm install

# Start development server
pnpm dev            # web ⬅︎→ api via turborepo
```

### 🎯 One-Line Developer Onboarding

```bash
curl -sSf https://raw.githubusercontent.com/Parlay-Kei/sshr-platform/main/tools/onboard.sh | bash
```

This script installs pnpm, pre-commit hooks, loads .env.example, and makes new contributors productive in minutes.

### Environment Setup

Create `.env` in `apps/web/`:

```makefile
DATABASE_URL=
AWS_REGION=
STRIPE_SECRET=
```

## 📁 Project Structure

```
sshr-platform/
├── apps/
│   └── web/                 # React frontend application
│       ├── src/
│       │   ├── components/  # Reusable UI components
│       │   ├── pages/       # Route components
│       │   ├── App.tsx      # Main app component
│       │   └── main.tsx     # App entry point
│       ├── package.json
│       └── vite.config.ts
├── packages/
│   └── common/              # Shared types and utilities
├── .github/                 # GitHub workflows and templates
├── package.json             # Root package.json
├── turbo.json              # Turborepo configuration
└── pnpm-workspace.yaml     # pnpm workspace config
```

## 🛠️ Development

### Available Scripts

```bash
# Development
pnpm dev              # Start all apps in development mode
pnpm dev --filter @sshr/web  # Start only web app

# Building
pnpm build            # Build all apps
pnpm build --filter @sshr/web  # Build only web app

# Testing
pnpm test             # Run all tests
pnpm test --filter @sshr/web  # Run only web app tests

# Linting
pnpm lint             # Lint all apps
pnpm lint --filter @sshr/web  # Lint only web app

# Formatting
pnpm format           # Format all code with Prettier
```

### Branch Strategy

- `master` - Production-ready code
- `develop` - Development branch
- `feature/*` - Feature branches
- `hotfix/*` - Hotfix branches

### Commit Convention

We follow [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` - New features
- `fix:` - Bug fixes
- `docs:` - Documentation changes
- `style:` - Code style changes
- `refactor:` - Code refactoring
- `test:` - Test additions/changes
- `chore:` - Build/tooling changes

## 🔒 Compliance stance
HIPAA Appendix D threat model

SOC-2 Type I controls mapped in `/docs/compliance`

## 📋 Roadmap → GitHub Projects
Milestones: Phase-0 Infra, Phase-1 E-forms, Phase-2 EHR, Phase-3 RCM, Phase-4 BI.

## 🤝 Contributing
See [CONTRIBUTING.md](./CONTRIBUTING.md) for Conventional Commit rules and local test suite.

### Development Workflow

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Run tests: `pnpm test`
5. Run linting: `pnpm lint`
6. Commit your changes: `git commit -m 'feat: add amazing feature'`
7. Push to the branch: `git push origin feature/amazing-feature`
8. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

## 🆘 Support

- 📧 Email: [your-email@example.com]
- 🐛 Issues: [GitHub Issues](https://github.com/Parlay-Kei/sshr-platform/issues)
- 📖 Documentation: [Wiki](https://github.com/Parlay-Kei/sshr-platform/wiki)

---

**Built with ❤️ for better healthcare**
