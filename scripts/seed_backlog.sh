#!/bin/bash

set -e

echo "🌱 Seeding SSHR Platform Backlog"
echo "================================="

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Helper function to create issues and add to project
create_issue() {
    local TITLE="$1"
    local BODY="$2"
    local LABELS="$3"
    local EPIC="$4"
    
    print_status "Creating issue: $TITLE"
    
    ISSUE_URL=$(gh issue create -t "$TITLE" -b "$BODY" -l "$LABELS" --project "SSHR Roadmap")
    
    if [[ -n "$EPIC" ]]; then
        gh issue edit "$ISSUE_URL" --add-label "$EPIC"
        print_success "Added to epic: $EPIC"
    fi
    
    print_success "Created: $ISSUE_URL"
    echo ""
}

# Create epic labels
print_status "Creating epic labels..."
gh label create "epic/phase-0-infra" -d "Infrastructure hardening epic" --color "0e8a16" 2>/dev/null || true
gh label create "epic/phase-1-forms" -d "E-Forms MVP epic" --color "1d76db" 2>/dev/null || true
gh label create "epic/phase-2-ehr" -d "EHR Integration epic" --color "d4c5f9" 2>/dev/null || true

# Create area labels if they don't exist
gh label create "area/infra" -d "Infrastructure work" --color "1d76db" 2>/dev/null || true
gh label create "area/backend" -d "Backend work" --color "d4c5f9" 2>/dev/null || true
gh label create "area/frontend" -d "Frontend work" --color "c2e0c6" 2>/dev/null || true

# Create priority labels if they don't exist
gh label create "priority/P0" -d "Critical priority" --color "d73a4a" 2>/dev/null || true
gh label create "priority/P1" -d "High priority" --color "fbca04" 2>/dev/null || true
gh label create "priority/P2" -d "Medium priority" --color "0e8a16" 2>/dev/null || true

print_success "Labels created"

echo ""
echo "📋 Creating Phase-0 Infrastructure Issues..."
echo "============================================"

# Phase-0 Infrastructure Issues
create_issue "Set up Terraform backend & state management" \
  "## Acceptance Criteria
- [ ] S3 backend configured for Terraform state
- [ ] DynamoDB table for state locking
- [ ] Remote state configuration in terraform.tf
- [ ] State encryption enabled
- [ ] Access logging enabled for S3 backend

## Technical Details
- Use S3 backend with DynamoDB locking
- Enable versioning and encryption
- Configure proper IAM roles and policies

**Priority**: P0
**Estimate**: 1 day
**Dependencies**: None" \
  "priority/P0,area/infra" "epic/phase-0-infra"

create_issue "Create VPC with private/public subnets" \
  "## Acceptance Criteria
- [ ] VPC with CIDR 10.0.0.0/16
- [ ] 3 private subnets across AZs
- [ ] 3 public subnets across AZs
- [ ] NAT gateways for private subnet internet access
- [ ] Internet gateway for public subnets
- [ ] Route tables configured
- [ ] Security groups defined

## Technical Details
- Use /24 subnets for each AZ
- Configure NAT gateways with EIPs
- Set up proper routing

**Priority**: P0
**Estimate**: 2 days
**Dependencies**: Terraform backend" \
  "priority/P0,area/infra" "epic/phase-0-infra"

create_issue "Configure RDS PostgreSQL with encryption" \
  "## Acceptance Criteria
- [ ] RDS PostgreSQL instance in private subnets
- [ ] Encryption at rest enabled
- [ ] Encryption in transit (SSL/TLS)
- [ ] Automated backups enabled
- [ ] Multi-AZ deployment
- [ ] Parameter group configured
- [ ] Security group allows app access

## Technical Details
- Use db.t3.micro for dev, db.r6g.large for prod
- Enable automated backups with 7-day retention
- Configure SSL certificate rotation

**Priority**: P0
**Estimate**: 1 day
**Dependencies**: VPC setup" \
  "priority/P0,area/infra" "epic/phase-0-infra"

create_issue "Set up S3 buckets with Object Lock" \
  "## Acceptance Criteria
- [ ] Audit logs bucket with Object Lock
- [ ] Application data bucket
- [ ] Backup bucket with lifecycle policies
- [ ] CORS configuration for web app
- [ ] Bucket policies configured
- [ ] Access logging enabled

## Technical Details
- Use Object Lock for compliance retention
- Configure lifecycle policies for cost optimization
- Set up proper bucket policies

**Priority**: P0
**Estimate**: 1 day
**Dependencies**: None" \
  "priority/P0,area/infra" "epic/phase-0-infra"

create_issue "Implement CloudWatch monitoring" \
  "## Acceptance Criteria
- [ ] CloudWatch dashboard created
- [ ] RDS metrics monitoring
- [ ] Application metrics collection
- [ ] Error rate alerting
- [ ] Performance monitoring
- [ ] Cost monitoring

## Technical Details
- Set up CloudWatch agents
- Configure custom metrics
- Create SNS topics for alerts

**Priority**: P1
**Estimate**: 2 days
**Dependencies**: RDS and S3 setup" \
  "priority/P1,area/infra" "epic/phase-0-infra"

create_issue "Create compliance evidence pipeline" \
  "## Acceptance Criteria
- [ ] Terraform plan output to S3
- [ ] GitHub Actions logs to S3
- [ ] Object Lock enabled for audit logs
- [ ] Automated evidence collection
- [ ] Compliance report generation
- [ ] Audit trail preservation

## Technical Details
- Use GitHub Actions to upload logs
- Configure S3 Object Lock for immutability
- Set up automated compliance reporting

**Priority**: P0
**Estimate**: 2 days
**Dependencies**: S3 setup" \
  "priority/P0,area/infra" "epic/phase-0-infra"

echo ""
echo "📋 Creating Phase-1 E-Forms Issues..."
echo "====================================="

# Phase-1 E-Forms Issues
create_issue "Patient intake form UI" \
  "## Acceptance Criteria
- [ ] Patient demographics form
- [ ] Insurance information collection
- [ ] Consent forms and signatures
- [ ] Form validation and error handling
- [ ] Mobile-responsive design
- [ ] Accessibility compliance (WCAG 2.1)

## Technical Details
- React 19 with TypeScript
- Form validation with Zod
- Responsive design with Tailwind CSS
- Accessibility with ARIA labels

**Priority**: P0
**Estimate**: 3 days
**Dependencies**: None" \
  "priority/P0,area/frontend" "epic/phase-1-forms"

create_issue "SMS scheduler microservice" \
  "## Acceptance Criteria
- [ ] SMS reminder scheduling
- [ ] Delivery status tracking
- [ ] Retry logic for failed messages
- [ ] Rate limiting and throttling
- [ ] Message templates
- [ ] Opt-out handling

## Technical Details
- NestJS microservice
- Twilio SMS integration
- Redis for job queue
- Database for delivery logs

**Priority**: P0
**Estimate**: 2 days
**Dependencies**: None" \
  "priority/P0,area/backend" "epic/phase-1-forms"

create_issue "Form data API endpoint" \
  "## Acceptance Criteria
- [ ] Form submission endpoint
- [ ] Data validation and sanitization
- [ ] Database storage
- [ ] SMS trigger integration
- [ ] Error handling and logging
- [ ] Rate limiting

## Technical Details
- RESTful API with NestJS
- PostgreSQL database
- Input validation with Zod
- Integration with SMS service

**Priority**: P0
**Estimate**: 2 days
**Dependencies**: SMS scheduler" \
  "priority/P0,area/backend" "epic/phase-1-forms"

echo ""
echo "📋 Creating Phase-2 EHR Integration Issues..."
echo "============================================="

# Phase-2 EHR Integration Issues
create_issue "FHIR API endpoints" \
  "## Acceptance Criteria
- [ ] Patient resource endpoint
- [ ] Encounter resource endpoint
- [ ] Observation resource endpoint
- [ ] DocumentReference endpoint
- [ ] FHIR compliance validation
- [ ] Authentication and authorization

## Technical Details
- FHIR R4 specification
- NestJS with FHIR libraries
- JWT authentication
- Role-based access control

**Priority**: P1
**Estimate**: 5 days
**Dependencies**: None" \
  "priority/P1,area/backend" "epic/phase-2-ehr"

create_issue "Chart migration utility" \
  "## Acceptance Criteria
- [ ] Bulk file upload capability
- [ ] Binary storage in S3
- [ ] Metadata extraction
- [ ] Audit trail logging
- [ ] Progress tracking
- [ ] Error recovery

## Technical Details
- File upload with multipart
- S3 integration for storage
- Background job processing
- Database for metadata

**Priority**: P1
**Estimate**: 4 days
**Dependencies**: S3 setup" \
  "priority/P1,area/backend" "epic/phase-2-ehr"

create_issue "EHR sync job" \
  "## Acceptance Criteria
- [ ] Scheduled synchronization
- [ ] Idempotent operations
- [ ] Error logging and alerting
- [ ] Conflict resolution
- [ ] Performance monitoring
- [ ] Data integrity checks

## Technical Details
- Cron job scheduling
- Database transactions
- Error handling and retries
- Monitoring and alerting

**Priority**: P2
**Estimate**: 3 days
**Dependencies**: FHIR endpoints" \
  "priority/P2,area/backend" "epic/phase-2-ehr"

echo ""
echo "📋 Creating Strategic Questions..."
echo "================================="

# Strategic Questions
create_issue "Frontend stack: React 19 browser compatibility" \
  "## Question
React 19 is bleeding-edge. Ready for concurrent features, but how will you handle legacy browser support for clinics on dusty PCs?

## Considerations
- Browser requirements assessment
- Polyfill strategy
- Fallback mechanisms
- Testing on legacy systems

## Priority**: P1
**Labels**: frontend,question" \
  "priority/P1,area/frontend,question"

create_issue "Data migrations: Chart scanning large binary uploads" \
  "## Question
Chart scanning implies large binary uploads. How do you version DB schema and object storage lifecycle?

## Considerations
- Large file handling strategy
- Database schema versioning
- Object storage lifecycle policies
- Migration rollback procedures

## Priority**: P1
**Labels**: backend,question" \
  "priority/P1,area/backend,question"

create_issue "RCM engine: Build from scratch vs vendor integration" \
  "## Question
Build from scratch or integrate with a vendor like Waystar? Scope creep risk looms.

## Considerations
- Build vs buy analysis
- Vendor evaluation criteria
- Integration complexity
- Cost-benefit analysis

## Priority**: P1
**Labels**: backend,question" \
  "priority/P1,area/backend,question"

echo ""
print_success "🎉 Backlog seeding complete!"
echo ""
echo "Next steps:"
echo "1. Visit the project board: https://github.com/users/Parlay-Kei/projects/4"
echo "2. Switch to Board view and add columns: Backlog → Todo → In-Progress → Done"
echo "3. Drag issues into appropriate columns"
echo "4. Start working on P0 infrastructure issues"
echo ""
print_success "SSHR Platform backlog is ready for development! 🚀" 