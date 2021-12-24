# Body - JSON

Returns the raw data, in JSON format, passed in the request body.

- **URL**

`/post`

- **Method**

`POST`

- **Body**

`{"someKey":"someValue"}`

- **Expected Responses**

  - Success
    - Code: `200`
    - Body: `{"someKey":"someValue"}`

- **Sample Call**

```
curl --location
--request POST 'URL/post'
--header 'Content-Type: application/json'
--data-raw '{"someKey":"someValue"}'
```
