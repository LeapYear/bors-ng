# Setting up a Scheduler in Heroku to truncate the database

## Logging into the Heroku account

Credentials are in LastPass:Shared-Engineering:Heroku Infrastructure

```
    $ heroku login -i
    heroku: Enter your login credentials
    Email [XXXXX]: <<<from LastPass>>>
    Password: <<<from LastPass>>>
```

## Installing the truncate script into Heroku

These steps need to be done once.
```
    $ heroku whoami
    XXXXX

    $ heroku addons:create -a leapyear-bors scheduler:standard
    Creating scheduler:standard on ⬢ leapyear-bors... free
     To manage scheduled jobs run:
     heroku addons:open scheduler

    Created scheduler-rugged-91687
    Use heroku addons:docs scheduler to view documentation

    $ heroku addons
    Owning App     Add-on                    Plan                         Price  State
    ─────────────  ────────────────────────  ───────────────────────────  ─────  ───────
    leapyear-bors  postgresql-defined-88827  heroku-postgresql:hobby-dev  free   created
    leapyear-bors  scheduler-rugged-91687    scheduler:standard           free   created

    $ git clone https://github.com/LeapYear/bors-ng.git
    $ cd bors-ng
    $ mkdir -p leapyear
    $ cp ../scheduler-truncate-bors-db.sh leapyear
    $ cp ../README-truncate.md leapyear
    $ git add .
    $ git commit -m 'Add scheduler-truncate-bors-db.sh'
    $ git push

    $ heroku addons:open scheduler
    <<< set execution schedule for scheduler-truncate-bors-db.sh >>>
    $ cd ..
    $ rm -rf bors-ng
```

## Viewing the Heroku log
```
    $ heroku whoami
    XXXXX
    $ heroku logs -a leapyear-bors -n 200
```
