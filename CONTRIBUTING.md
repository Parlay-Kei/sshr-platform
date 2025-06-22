# Contributing to SSHR Platform

Thank you for considering contributing to the SSHR Platform! This document outlines the process and guidelines for contributing to this project.

## Development Workflow

1. **Fork the repository**
   - Create your own fork of the repository to work on

2. **Create a branch**
   - Create a branch for your feature or bugfix
   - Use a descriptive name that reflects the purpose of your changes
   - Example: `feat/patient-registration-form` or `fix/auth-token-expiry`

3. **Submit a Pull Request**
   - Once your changes are ready, submit a pull request to the main repository
   - Link your PR to the relevant issue
   - One feature or fix per PR

## Commit Guidelines

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification for commit messages:

- `feat:` - A new feature
- `fix:` - A bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, etc.)
- `refactor:` - Code changes that neither fix bugs nor add features
- `perf:` - Performance improvements
- `test:` - Adding or updating tests
- `chore:` - Changes to the build process, tooling, etc.

Example: `feat: add patient registration form component`

## Code Style

- Follow the existing code style in the repository
- Use TypeScript for all new code
- Write tests for new features and bug fixes
- Document public APIs and complex logic

## Testing

Before submitting a PR, ensure:

1. All tests pass: `pnpm test`
2. Linting passes: `pnpm lint`
3. The build succeeds: `pnpm build`

## Documentation

- Update documentation when changing functionality
- Document new features
- Keep API documentation up-to-date

## Compliance Considerations

When contributing to SSHR Platform, be mindful of HIPAA and other healthcare compliance requirements:

- Never commit PHI (Protected Health Information) or test data that resembles PHI
- Consider security implications of all changes
- Document potential compliance impacts in your PR description

## Questions?

If you have questions about contributing, please open an issue for discussion.
