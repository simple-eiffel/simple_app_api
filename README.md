<p align="center">
  <img src="https://raw.githubusercontent.com/ljr1981/claude_eiffel_op_docs/main/artwork/LOGO.png" alt="simple_ library logo" width="400">
</p>

# simple_app_api

**[Documentation](https://ljr1981.github.io/simple_app_api/)** | **[GitHub](https://github.com/ljr1981/simple_app_api)**

Unified application layer facade for Eiffel applications. Provides web client and Alpine.js components, plus inherited access to all service and foundation features.

## Overview

`simple_app_api` provides a single `APP` class that gives you access to application-level services. It inherits from `SERVICE`, which inherits from `FOUNDATION`, giving you access to all three API layers through one object.

## Features

- **Web Client** - HTTP client for making web requests
- **Alpine.js** - Generate Alpine.js interactive components
- **Service Layer** - Inherits JWT, SMTP, SQL, CORS, Rate Limiting, Templates, WebSocket
- **Foundation** - Inherits Base64, Hashing, UUID, JSON, CSV, Markdown, Validation, Process, Random

## Dependencies

This library bundles the following application libraries:

| Library | Purpose | Environment Variable |
|---------|---------|---------------------|
| [simple_web](https://github.com/ljr1981/simple_web) | HTTP client and web requests | `$SIMPLE_WEB` |
| [simple_alpine](https://github.com/ljr1981/simple_alpine) | Alpine.js component generation | `$SIMPLE_ALPINE` |
| [simple_service_api](https://github.com/ljr1981/simple_service_api) | Service layer (inherited) | `$SIMPLE_SERVICE_API` |

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
    app: APP
do
    create app.make

    -- Alpine.js Components
    factory := app.new_alpine_factory
    div := app.alpine.div
    div.x_data ("{count: 0}")

    -- Web Client
    client := app.new_web_client
    request := app.new_get_request ("https://api.example.com/users")

    -- Service layer (inherited)
    token := app.create_token ("secret", "user", "app", 3600)
    db := app.new_memory_database
    cors := app.new_cors
    limiter := app.new_rate_limiter (100, 60)

    -- Foundation layer (inherited)
    encoded := app.base64_encode ("data")
    hash := app.sha256 ("password")
    uuid := app.new_uuid
    json := app.parse_json ("{%"key%": %"value%"}")
end
```

## API Summary

### Web Client
- `new_web_client` - Create HTTP client
- `new_get_request (url)` - Create GET request
- `new_post_request (url)` - Create POST request
- `web_client` - Direct access (singleton)

### Alpine.js
- `new_alpine_factory` - Create Alpine.js element factory
- `alpine` - Direct access to Alpine factory (singleton)

### Inherited from SERVICE
- **JWT** - `new_jwt`, `create_token`, `verify_token`
- **SMTP** - `new_smtp`
- **SQL** - `new_database`, `new_memory_database`
- **CORS** - `new_cors`, `new_cors_permissive`
- **Rate Limiting** - `new_rate_limiter`
- **Templates** - `new_template`, `render_template`
- **WebSocket** - `new_ws_handshake`, `new_ws_text_frame`, etc.

### Inherited from FOUNDATION
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
| simple_app_api (Application Layer) *     |
+------------------------------------------+
                   |
                   v
+------------------------------------------+
| simple_service_api (Service Layer)       |
+------------------------------------------+
                   |
                   v
+------------------------------------------+
| simple_foundation_api (Foundation)       |
+------------------------------------------+
```

## License

MIT License - Copyright (c) 2024-2025, Larry Rix
