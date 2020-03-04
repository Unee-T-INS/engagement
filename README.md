# Overview:

This is used to build the engagement reports that we need when we send email to user.

This is a mandatory repo, omitting this will break the links that we add in the emails to our users.

See [GH issue #26](https://github.com/Unee-T-INS/frontend/issues/26) for more details.

# Pre-Requisite:

- This is intended to be deployed on AWS.
- We use Travis CI for automated deployment.

The following variables MUST be declared in order for this to work as intended:

## AWS variables:

These should be decleared in the AWS Parameter Store for this environment.
- STAGE
- DOMAIN
- EMAIL_FOR_NOTIFICATION_GENERIC

## Travic CI variables:

These should be declared as Settings in Travis CI for this Repository.

### For all environments:
 - AWS_DEFAULT_REGION
 - GITHUB_TOKEN

### For dev environment:
 - AWS_ACCOUNT_USER_ID_DEV
 - AWS_ACCOUNT_SECRET_DEV
 - AWS_PROFILE_DEV

### For Demo environment:
 - AWS_ACCOUNT_USER_ID_DEMO
 - AWS_ACCOUNT_SECRET_DEMO
 - AWS_PROFILE_DEMO

### For Prod environment:
 - AWS_ACCOUNT_USER_ID_PROD
 - AWS_ACCOUNT_SECRET_PROD
 - AWS_PROFILE_PROD

# Deployment:

Deployment is done automatically with Travis CI:
- For the DEV environment: each time there is a change in the `master` repo for this codebase
- For the PROD and DEMO environment: each time we do a tag release for this repo.

# Maintenance:

To get the latest version of the go modules we need, you can run:
`go get -u`

See the [documentation on go modules](https://blog.golang.org/using-go-modules) for more details.

# Logs

Show engagements over email:

	up logs 'medium = "email"'

Show notifications of type foobar:

	up logs 'id = "foobar*"'
