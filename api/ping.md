# Path Variables

Returns the path variables in the URL.

- **URL**

`/:ping`

- **Method**

`GET`

- **Path Variable**

`ping = whatever`

- **Expected Responses**

  - Success
    - Code: `200`
    - Body: `pong`

- **Sample Call**

```
curl --location
--request GET 'URL/ping'
```
