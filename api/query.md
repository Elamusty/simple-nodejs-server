# Query Parameters

Returns the query parameters passed in the URL.

- **URL**

`/query?someKey=someValue`

- **Method**

`GET`

- **Query Params**

`someKey = someValue`

\*whatever and as many as you want in the format

- **Expected Responses**

  - Success
    - Code: `200`
    - Body: `{"someKey":"someValue"}`

- **Sample Call**

```
curl --location
--request GET 'URL/query?someKey=someValue'
```
