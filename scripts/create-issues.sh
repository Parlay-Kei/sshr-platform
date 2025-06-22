#!/bin/bash

# Phase-0 Infrastructure Child Issues
echo "Creating Phase-0 infrastructure child issues..."

# Issue 1: Terraform Backend
gh issue create --title "Set up Terraform backend and state management" \
  --body "## Acceptance Criteria
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
  --label "infra,p0"

# Issue 2: VPC Setup
gh issue create --title "Create VPC with private/public subnets" \
  --body "## Acceptance Criteria
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
  --label "infra,p0"

# Issue 3: RDS Configuration
gh issue create --title "Configure RDS PostgreSQL with encryption" \
  --body "## Acceptance Criteria
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
  --label "infra,p0"

# Issue 4: S3 Buckets
gh issue create --title "Set up S3 buckets with Object Lock" \
  --body "## Acceptance Criteria
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
  --label "infra,p0"

# Issue 5: CloudWatch Monitoring
gh issue create --title "Implement CloudWatch monitoring" \
  --body "## Acceptance Criteria
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
  --label "infra,p1"

# Issue 6: Compliance Pipeline
gh issue create --title "Create compliance evidence pipeline" \
  --body "## Acceptance Criteria
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
  --label "infra,p0"

echo "Phase-0 issues created successfully!" 