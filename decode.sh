#!/bin/bash

. .secrets.admin.sh

ENCODED_MSG=$1
exit_code=0

if [[ ! -d bin/lib/fancy-bash ]]; then
  git submodule add git@github.com:jpgrace/fancy-bash.git bin/lib/fancy-bash
fi

git submodule update --init --recursive

. bin/lib/fancy-bash/colors.sh
. bin/lib/fancy-bash/fonts.sh

if [[ ! $(command -v aws) ]]; then
  echo "${COLOR_RED}${FONT_BOLD}Failure!${FONT_DEFAULT} ${COLOR_RED}The AWS CLI was not found and is required. Please ensure that it is installed. See: ${COLOR_BLUE}${FONT_UNDERLINE}https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html${FONT_DEFAULT}"
  exit_code=1
fi

if [[ ! $(command -v jq) ]]; then
  echo "${COLOR_RED}${FONT_BOLD}Failure!${FONT_DEFAULT} ${COLOR_RED}jq was not found and is required. Please ensure that it is installed. See: ${COLOR_BLUE}${FONT_UNDERLINE}https://stedolan.github.io/jq/download/${FONT_DEFAULT}"
  exit_code=1
fi

if [[ $exit_code == 0 ]]; then
  aws sts decode-authorization-message --encoded-message "${ENCODED_MSG}" | jq '.DecodedMessage | fromjson'
fi

exit $exit_code
