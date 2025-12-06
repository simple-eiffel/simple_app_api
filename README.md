# simple_app_api

Unified application layer facade for Eiffel applications. Provides a single `APP` class that gives access to web client, Alpine.js components, and all service/foundation features through inheritance.

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

The `APP` class inherits from `SERVICE`, which inherits from `FOUNDATION`. This gives you access to all three API layers through a single object.

## Bundled Libraries

| Library | Purpose |
|---------|---------|
| [simple_web](https://ljr1981.github.io/simple_web/) | HTTP client and web requests |
| [simple_alpine](https://ljr1981.github.io/simple_alpine/) | Alpine.js component generation |
| [simple_service_api](https://ljr1981.github.io/simple_service_api/) | Service layer (inherited) |
| [simple_foundation_api](https://ljr1981.github.io/simple_foundation_api/) | Foundation layer (inherited) |

## Installation

Add to your ECF:

```xml
<library name="simple_app_api" location="$SIMPLE_APP_API\simple_app_api.ecf"/>
```

Set environment variable:
```
SIMPLE_APP_API=path/to/simple_app_api
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

    -- Service layer features (inherited)
    token := app.create_token ("secret", "user", "app", 3600)
    db := app.new_memory_database
    cors := app.new_cors
    limiter := app.new_rate_limiter (100, 60)

    -- Foundation features (inherited)
    encoded := app.base64_encode ("data")
    hash := app.sha256 ("password")
    uuid := app.new_uuid
    json := app.parse_json ("{%"key%": %"value%"}")
end
```

## API Reference

### Web Client

| Feature | Description |
|---------|-------------|
| `new_web_client` | Create HTTP client |
| `new_get_request (url)` | Create GET request |
| `new_post_request (url)` | Create POST request |
| `web_client` | Direct access (singleton) |

### Alpine.js

| Feature | Description |
|---------|-------------|
| `new_alpine_factory` | Create Alpine.js element factory |
| `alpine` | Direct access to Alpine factory (singleton) |

### Inherited from SERVICE

| Category | Features |
|----------|----------|
| JWT | `new_jwt`, `create_token`, `verify_token` |
| SMTP | `new_smtp` |
| SQL | `new_database`, `new_memory_database` |
| CORS | `new_cors`, `new_cors_permissive` |
| Rate Limiting | `new_rate_limiter` |
| Templates | `new_template`, `render_template` |
| WebSocket | `new_ws_handshake`, `new_ws_text_frame`, etc. |

### Inherited from FOUNDATION

| Category | Features |
|----------|----------|
| Base64 | `base64_encode`, `base64_decode`, `base64_url_encode` |
| Hashing | `sha256`, `sha1`, `md5`, `hmac_sha256`, `secure_compare` |
| UUID | `new_uuid`, `new_uuid_compact`, `is_valid_uuid` |
| JSON | `parse_json`, `new_json_object`, `new_json_array` |
| CSV | `parse_csv`, `csv_field`, `csv_to_string` |
| Markdown | `markdown_to_html` |
| Validation | `new_validator`, `is_valid_email`, `is_valid_url` |
| Process | `execute_command` |
| Random | `random_integer`, `random_word`, `random_alphanumeric_string` |

## License

MIT License - Copyright (c) 2024-2025, Larry Rix
