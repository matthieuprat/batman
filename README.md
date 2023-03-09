# Batman 🦇

[Robin][1]'s companion.

![Robin and Batman](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExYWFlNDA5NWUyMWU3MDllZTk4MTBiZjJjN2I4Zjk0NzQzMjYzZjIzNSZjdD1n/1485wMdlDLG7mg/giphy.gif)

## What does Batman do?

Batman books your desk on [Robin][1] so you don't have to. Just tell him which days you're
in and Batman will take care of the rest.

## How does Batman work?

Batman works [every weekday around 1 AM UTC][2]. It reads the [`batman.yml`][5] file to check
which desks it shall book and, well, books them.

## Bonanza, I'm in. What should I do?

If you'd like Batman to deal with Robin on your behalf:

1. Open [`batman.yml`][3]

2. Duplicate an existing entry and replace `github_username` and `email` with your own.
   Also set the list of days on which you want Batman to book a desk for you.

3. Head to the [Robin dashboard][4]

4. Spot a couple of desks you fancy (e.g. "Desk 1" and "Desk 2"). Add them to your own
   `batman.yml` entry under the `desks` key. Batman will try to book each desk in order
   one after the other until it succeeeds.

5. Open the developer tools of your browser and run the following snippet to copy your Robin access token:
   ```js
   copy(JSON.parse(decodeURIComponent(document.cookie.match("_rbn_session=(.*?);")[1])).access_token)
   ```

6. Encrypt your access token:
   ```bash
   ./encrypt
   ```

7. Copy and paste the encrypted access token to your own `batman.yml` entry

8. Yolo the changes to the `main` branch

[1]: https://robinpowered.com
[2]: .github/workflows/batman.yml
[3]: ../../edit/main/batman.yml
[4]: https://dashboard.robinpowered.com/gocardless/office?locations=767466&levels=206728
[5]: batman.yml
