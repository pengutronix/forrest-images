Forrest Runner images used by Pengutronix
=========================================

                                        ┏━━━━━━━━━━━━━━━┓
                                        ┃      Run      ┃
                                        ┃    Forrest    ┃
                                        ┃      Run      ┃
                                        ┗━━━┯━━━━━━━┯━━━┛

---

This repository contains [Forrest][forrest-project] machine
set up actions.
If these words do not make sense to you, you should start your journey at the
link above.

To use these jobs you will need a [Forrest][forrest-project] runner with a
config that looks something like this:

```yaml
host:
  base_dir: /srv/gh-runner/forrest
  ram: 32G

github:
  app_id: [YOUR APP ID]
  jwt_key_file: [PATH TO YOUR JWT KEY]
  webhook_secret: [YOUR GITHUB WEBHOOK SECRET]

repository_snippets:
  image-machines: &image-machines
    machines:
      generator: &image-generator
        setup_template:
          path: /etc/forrest/templates/generic
          parameters:
            RUNNER_VERSION: "2.323.0"
            RUNNER_HASH: "0dbc9bf5a58620fc52cb6cc0448abcca964a8d74b5f39773b7afcad9ab691e19"
        use_base: always
        cpus: 4
        disk: 16G
        ram: 4G

repositories:
  pengutronix:
    forrest-images:
      persistence_token: [A RANDOM PERSISTENCE TOKEN]
      machines:
        debian-bookworm-base:
          << : *image-generator
          base_image: /srv/gh-runner/forrest/images/debian-12-generic-amd64.raw
        debian-bookworm-debos:
          << : *image-generator
          base_machine: pengutronix/forrest-images/debian-bookworm-base
        debian-bookworm-ptxdist:
          << : *image-generator
          base_machine: pengutronix/forrest-images/debian-bookworm-base
        debian-bookworm-yocto:
          << : *image-generator
          base_machine: pengutronix/forrest-images/debian-bookworm-base
```

The jobs will set up images for use with debos, ptxdist and yocto jobs from
plain Debian generic [cloud images](https://cloud.debian.org/images/cloud/).

See the [workflow file](.github/workflows/debian-bookworm.yaml) for more information.

Refer to the [Forrest][forrest-project] documentation for information on how
actually to use these machine images.

---

                                        ┏━━━━━━━━━━━━━━┓
                                        ┃     Stop     ┃
                                        ┃    Forrest   ┃
                                        ┃     Stop     ┃
                                        ┗━━━┯━━━━━━┯━━━┛

[forrest-project]: https://github.com/forrest-runner/forrest/
