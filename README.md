# Kong External Auth

Kong plugin to authenticate requests using http services.

## Description

This plugin lets you authenticate any request using a separate HTTP service.

For every incoming request, the `method`, `path`, `query` and `headers` are forwarded to the auth service (removing the body).

If the service returns `200`, the request continues the normal path.
In any other case, `401` (Unauthorized) is returned to the client.

## Installation

```bash
$ luarocks install external-auth
```

Update the `plugins` config to add `external-auth`:

```
plugins = bundled,external-auth
```

## Configuration

Add it to a service calling the admin api:

```bash
$ curl -X POST http://kong:8001/services/{service}/plugins \
  -d 'name=external-auth' \
  -d 'config.url=http://auth-service/'
```

| Parameter | default | description |
| ---       | ---     | ---         |
| `config.url` | [required] | Service receiving the original request method, path, query, headers. **Http** and **https** are allowed. |
| `config.connect_timeout` | 10000 | Connection timeout (in ms) to the provided url. |
| `config.send_timeout` | 60000 | Send timeout (in ms) to the provided url. |
| `config.read_timeout` | 60000 | Read timeout (in ms) to the provided url. |

### TODO
- Allow auth service response headers to be inserted to the request (currently, only the status code of the response is used).
- On failure, allow auth service response to be returned to the client.
- Use path from the configured url (currently always overrides the auth service path with the one from the incoming request).

## References
Inspired on Ambassador's auth service

https://www.getambassador.io/reference/services/auth-service

## Author
Pablo Romanelli

## License
```
The MIT License (MIT)
=====================

Copyright (c) 2015 Panagis Tselentis

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
