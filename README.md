<p align="center">
  <img src="https://raw.githubusercontent.com/ljr1981/claude_eiffel_op_docs/main/artwork/LOGO.png" alt="simple_ library logo" width="400">
</p>

# simple_app_api

**[Documentation](https://ljr1981.github.io/simple_app_api/)** | **[GitHub](https://github.com/ljr1981/simple_app_api)**

Unified application layer facade for Eiffel applications. Provides web client and Alpine.js components, with compositional access to service and foundation layers.

## Overview

`simple_app_api` provides a single `APP_API` class that gives you access to application-level services. It uses composition to provide access to `SERVICE_API` and `FOUNDATION_API`, giving clear semantic separation between API layers.

## Features

- **Web Client** - HTTP client for making web requests
- **Alpine.js** - Generate Alpine.js interactive components
- **Service Layer** - Access via `api.service.*` for JWT, SMTP, SQL, CORS, Rate Limiting, Templates, WebSocket
- **Foundation** - Access via `api.foundation.*` for Base64, Hashing, UUID, JSON, CSV, Markdown, Validation, Process, Random

## Dependencies

This library bundles the following application libraries:

| Library | Purpose | Environment Variable |
|---------|---------|---------------------|
| [simple_web](https://github.com/ljr1981/simple_web) | HTTP client and web requests | `$SIMPLE_WEB` |
| [simple_alpine](https://github.com/ljr1981/simple_alpine) | Alpine.js component generation | `$SIMPLE_ALPINE` |
| [simple_service_api](https://github.com/ljr1981/simple_service_api) | Service layer (composed) | `$SIMPLE_SERVICE_API` |
| [simple_foundation_api](https://github.com/ljr1981/simple_foundation_api) | Foundation layer (composed) | `$SIMPLE_FOUNDATION_API` |

## Installation

1. Clone all required repositories
2. Set environment variables for each library
3. Add to your ECF:

```xml
<library name="simple_app_api"
        location="$SIMPLE_APP_API\simple_app_api.ecf"/>
```

## Quick Start

```eiffel
local
    api: APP_API
do
    create api.make

    -- App-level: Alpine.js Components
    factory := api.new_alpine_factory
    div := api.alpine.div
    div.x_data ("{count: 0}")

    -- App-level: Web Client
    client := api.new_web_client
    request := api.new_get_request ("https://api.example.com/users")

    -- Service layer (via composition)
    token := api.service.create_token ("secret", "user", "app", 3600)
    db := api.service.new_memory_database
    cors := api.service.new_cors
    limiter := api.service.new_rate_limiter (100, 60)

    -- Foundation layer (via composition)
    encoded := api.foundation.base64_encode ("data")
    hash := api.foundation.sha256 ("password")
    uuid := api.foundation.new_uuid
    json := api.foundation.parse_json ("{%"key%": %"value%"}")
end
```

## API Summary

### App-Level Features

#### Web Client
- `new_web_client` - Create HTTP client
- `new_get_request (url)` - Create GET request
- `new_post_request (url)` - Create POST request
- `web_client` - Direct access (singleton)

#### Alpine.js
- `new_alpine_factory` - Create Alpine.js element factory
- `alpine` - Direct access to Alpine factory (singleton)

### Layer Access

- `service` - Access to SERVICE_API features
- `foundation` - Access to FOUNDATION_API features

### Via `api.service.*`
- **JWT** - `new_jwt`, `create_token`, `verify_token`
- **SMTP** - `new_smtp`
- **SQL** - `new_database`, `new_memory_database`
- **CORS** - `new_cors`, `new_cors_permissive`
- **Rate Limiting** - `new_rate_limiter`
- **Templates** - `new_template`, `render_template`
- **WebSocket** - `new_ws_handshake`, `new_ws_text_frame`, etc.

### Via `api.foundation.*`
- **Base64** - `base64_encode`, `base64_decode`, `base64_url_encode`
- **Hashing** - `sha256`, `sha1`, `md5`, `hmac_sha256`, `secure_compare`
- **UUID** - `new_uuid`, `new_uuid_compact`, `is_valid_uuid`
- **JSON** - `parse_json`, `new_json_object`, `new_json_array`
- **CSV** - `parse_csv`, `csv_field`, `csv_to_string`
- **Markdown** - `markdown_to_html`
- **Validation** - `new_validator`, `is_valid_email`, `is_valid_url`
- **Process** - `execute_command`
- **Random** - `random_integer`, `random_word`, `random_alphanumeric_string`

## Architecture

```
+------------------------------------------+
| APP_API (Application Layer)              |
|   - alpine, web_client                   |
|   - service (composition)                |
|   - foundation (composition)             |
+------------------------------------------+
         |                    |
         v                    v
+------------------+  +------------------+
| SERVICE_API      |  | FOUNDATION_API   |
| - jwt, smtp,     |  | - base64, hash,  |
|   sql, cors,     |  |   uuid, json,    |
|   templates,     |  |   csv, markdown, |
|   websocket      |  |   validation,    |
| - foundation     |  |   process,       |
|   (composition)  |  |   random         |
+------------------+  +------------------+
         |
         v
+------------------+
| FOUNDATION_API   |
+------------------+
```

## Design Philosophy

**Composition over Inheritance**: Each API layer provides clear semantic boundaries. When you type `api.`, IntelliSense shows only app-level features. Use `api.service.*` for service features and `api.foundation.*` for foundation features. This makes code self-documenting and easier to understand.

## License

MIT License - Copyright (c) 2024-2025, Larry Rix
