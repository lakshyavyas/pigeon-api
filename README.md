# Pigeon
```text
Under Development
```

# Features

- Supports SAML, OpenId connect auth
- Seamless integration of chat and ticketing system, all types on conversations are represented as a chat
- Out of the box support for:
    - Github
    - Bitbucket
    - AWS Cloudwatch alerts
    - more coming soon
- Transparent guide to create your own app and use it
    - OAuth support for external apps
- Ticketing via email, live chat
- Ticketing via SMS, WhatsApp (coming soon)

# Contributing
Bug Reports and PR's are welcomed in this repository kindly follow guidelines from `.github` directory.

- Use of TDD is a must, any feature needed will have pending case in features directory of spec

## Useful Commands
On top of regular commands comes out of box from rails, below is description of commands for specific purpose

### Run Test Suite (RSpec)
```shell
rails test
# OR
rails t
```

### Run Test Suite[Only Features] (RSpec)
```shell
rails test:request
# or
rails tf
```

### Run Rubocop (lint)
```shell
rails lint
```

### Run Rubocop (lint) with -A (Auto Fix)
```shell
rails lint:fix
```

### Run Annotate (annotate gem)
```shell
rails annotate
```

### Generate ERD from Schema (rails-erd gem)
```shell
rails erd
```

### Generate features.md in design folder
```shell
rails features
```

### Generate OpenAPI spec in design folder
```shell
rails openapi
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mutils project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/code-vedas/pigeon-api/blob/main/CODE_OF_CONDUCT.md).

## Security

For security refer to [security](https://github.com/Code-Vedas/pigeon-api/blob/main/SECURITY.md) document.
