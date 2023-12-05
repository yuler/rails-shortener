# rails shortener

> A url shortener power by rails, <https://yuler.cc>

## Stack

- Deploy by [kamal](https://kamal-deploy.org/)

## Note

- This repo is for learn rails from [Build a URL Shortener with Rails 7](https://gorails.com/series/build-a-url-shortener-with-rails-7). [YouTube](https://www.youtube.com/watch?v=XHRUjXUcr04&list=PLm8ctt9NhMNXOBboD4FvLdZU_Cner2uk0&index=1), [Source Code](https://github.dev/gorails-screencasts/url-shortener)

## Related

- <https://github.com/steven-tey/dub>
- <https://github.com/thedevs-network/kutt>
- <https://github.com/nelsontky/gh-pages-url-shortener>
- <https://github.com/formkit/shorten>

## API

```bash
TOKEN=xxx # https://yuler.cc/djtjA6bOM1
curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d '{"link": {"url": "https://github.com/yuler"}}' https://yuler.cc/api/links
curl -H "Authorization: Bearer $TOKEN" https://yuler.cc/api/links
```

## TODO

- [ ] Fix cookies['link_form_url'] not work
- [ ] Design Home Page
- [ ] Add widget for other site embed
