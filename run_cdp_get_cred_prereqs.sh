#!/usr/bin/env bash

#################################################
# Bash script to extract the account id and
# external id of the CDP Public Cloud control plane.
#
# Accepts the Cloud Provider type as a dictionary input
# and uses the command
#    'cdp environments get-credential-prerequisites'
# to then determine the ids. These are then returned as a
# JSON object for use in the TF pre-reqs module.
#############################

# Step 1 - Parse the input and get upper and lower case version
eval "$(jq -r '@sh "infra_type=\(.infra_type)"')"

# Lower case, bash 4+ syntax
infra_type_lower=${infra_type,,}
# Upper case, bash 4+ syntax
infra_type_upper=${infra_type^^}

# Step 2 - Run the cdpcli command
export CDP_OUTPUT=$(cdp environments get-credential-prerequisites --cloud-platform ${infra_type_upper} --output json)

# Step 3 - Parse required outputs into variables
accountId=$(echo $CDP_OUTPUT | jq --raw-output '.accountId')
externalId=$(echo $CDP_OUTPUT | jq --arg infra_type "$infra_type_lower" --raw-output '.[$infra_type].externalId')

# Step 4 - Output in JSON format
jq -n --arg accountId $accountId \
      --arg externalId $externalId \
      --arg infra_type "$infra_type_lower" \
      '{"infra_type":$infra_type, "account_id":$accountId, "external_id":$externalId}'

# Step 3-4 - All-in-one alternative
# echo $CDP_OUTPUT | jq --arg infra_type "$infra_type_lower" '{"infra_type":$infra_type, "accountId":.accountId, "externalId":.[$infra_type].externalId}'
    