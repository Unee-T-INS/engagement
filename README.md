# Overview:

This is used to build the engagement reports that we need when we send email to user.

This is a mandatory repo, omitting this will break the links that we add in the emails to our users.

See [GH issue #26](https://github.com/Unee-T-INS/frontend/issues/26) for more details.

# Logs

Show engagements over email:

	up logs 'medium = "email"'

Show notifications of type foobar:

	up logs 'id = "foobar*"'
