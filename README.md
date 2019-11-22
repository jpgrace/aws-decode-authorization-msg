# aws-decode-authorization-msg

A bash script for decoding an AWS encoded authorization message.

## Prerequisites

- The AWS CLI
- The jq script
- Fancy-bash

## Usage

The script expects your AWS credentials to be exported in `.secrets.admin.sh`.

```
$ echo "export AWS_PROFILE=my-profile" | tee .secrets.admin.sh
$ ./decode.sh <my-encoded-aws-message>
```
