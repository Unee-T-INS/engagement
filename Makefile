# The variable TRAVIS_AWS_PROFILE is set when .travis.yml runs

# We create a function to simplify getting variables for aws parameter store.
# The variable TRAVIS_AWS_PROFILE is set when .travis.yml runs

define ssm
$(shell aws --profile $(TRAVIS_AWS_PROFILE) ssm get-parameters --names $1 --with-decryption --query Parameters[0].Value --output text)
endef

# The other variables needed up in UPJSON and PRODUPJSON are set when `source ./aws.env` runs
# - STAGE
# - DOMAIN
# - EMAIL_FOR_NOTIFICATION_GENERIC
# These variables can be edited in the AWS parameter store for the environment

UPJSON = '.profile |= "$(TRAVIS_AWS_PROFILE)" \
		  |.stages.production |= (.domain = "e.$(call ssm,STAGE).$(call ssm,DOMAIN)" | .zone = "$(call ssm,STAGE).$(call ssm,DOMAIN)") \
		  | .actions[0].emails |= ["$(call ssm,EMAIL_FOR_NOTIFICATION_GENERIC)"]'

PRODUPJSON = '.profile |= "$(TRAVIS_AWS_PROFILE)" \
		  |.stages.production |= (.domain = "e.$(call ssm,DOMAIN)" | .zone = "$(call ssm,DOMAIN)") \
		  | .actions[0].emails |= ["$(call ssm,EMAIL_FOR_NOTIFICATION_GENERIC)"] '

# We have everything, we can run up now.

dev:
	@echo $$AWS_ACCESS_KEY_ID
	# We replace the relevant variable in the up.json file
	# We use the template defined in up.json.in for that
	jq $(UPJSON) up.json.in > up.json
	# BEGING VERY HACKY STUFF
	# try to go around a deployment issue...
	up stack delete
	# END 
	up deploy production

demo:
	@echo $$AWS_ACCESS_KEY_ID
	# We replace the relevant variable in the up.json file
	# We use the template defined in up.json.in for that
	jq $(UPJSON) up.json.in > up.json
	up deploy production

prod:
	@echo $$AWS_ACCESS_KEY_ID
	# We replace the relevant variable in the up.json file
	# We use the template defined in up.json.in for that
	jq $(PRODUPJSON) up.json.in > up.json
	up deploy production

.PHONY: dev demo prod
