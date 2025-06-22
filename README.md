# SSHR Platform

A four-phase digital stack that drags small clinics out of paper purgatory.

## Why it exists
Patients lose time; staff drown in clipboards; revenue leaks through denial cycles. \
SSHR stitches those gaps with:

1. **E-forms + SMS reminders** (≤30 days)
2. **Cloud EHR + chart scanning** (≤90 days)
3. **Automated eligibility + clean-claim RCM** (≤120 days)
4. **BI dashboards for visits, denials, no-shows** (≤150 days)

## Architecture

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

## Getting started

```bash
pnpm install
pnpm dev            # web ⬅︎→ api via turborepo
```

Create `.env`:

```makefile
DATABASE_URL=
AWS_REGION=
STRIPE_SECRET=
```

## Compliance stance
HIPAA Appendix D threat model

SOC-2 Type I controls mapped in `/docs/compliance`

## Roadmap → GitHub Projects
Milestones: Phase-0 Infra, Phase-1 E-forms, Phase-2 EHR, Phase-3 RCM, Phase-4 BI.

## Contributing
See CONTRIBUTING.md for Conventional Commit rules and local test suite.
