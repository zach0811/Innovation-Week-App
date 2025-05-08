#!/bin/bash

set -e
source update_ui_versions.sh

# Ensure PR_URL is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <PR_URL>"
  exit 1
fi

PR_URL="$1"

echo "Sending Slack notification for PR: $PR_URL"
echo "New version: $NEW_VERSION"

curl --location 'https://hooks.slack.com/services/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' \
  --header 'Content-Type: application/json' \
  --data '{
    "blocks": [
      {
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": "A pull request has been created to update Customer-UI for Customer-Elements version: '"${NEW_VERSION}"'.\nClick here to review the pull request. :point_right:"
        },
        "accessory": {
          "type": "button",
          "text": {
            "type": "plain_text",
            "text": "Review PR"
          },
          "url": "'"${PR_URL}"'",
          "action_id": "button"
        }
      }
    ]
  }'