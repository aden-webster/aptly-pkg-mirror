# Aptly Scripts for Automatic Repository Mirroring

I had the task of setting up Aptly at work and got hung up on many parts of it. It has a lot of rope to get caught on, so I hope this helps somebody if you have the task of setting up local repositories or mirrors of remote repos.

[Aptly](https://www.aptly.info/) has pretty good [documentation](https://www.aptly.info/doc/overview/) but actually using it in a live environment with many machines is very different and gets messy fast.

#### Things to Know:

The Dockerfile is mostly just for my testing but you can certainly use it. It will spin up an Ubuntu image with Aptly installed. You will need to create mirrors/publish them as usual.

The bulk of this project is in shell scripts, and expects some sort of automatic execution every x days or hours. I've included a systemd service file as an example.

## Usage:

1. Create Mirrors
    - The shell script `create-mirrors.sh` will create mirrors. 
    - Syntax is `bash create-mirrors.sh <distro> <repo> <URL>`
    - Example: `bash create-mirrors.sh jammy main http://archive.ubuntu.com/ubuntu`
        - This will create a mirror of the Jammy Main repository from Ubuntu.

### Note on GPG: 
GPG keys are required by `apt` to create mirrors, and this should be handled automatically by the script but you might have to import some keys manually before creating the mirrors.

To do that, note the key ID that Aptly downloads in the stdout:

```
Success downloading http://archive.ubuntu.com/ubuntu/dists/jammy/Release.gpg
gpgv: Signature made Thu Apr 21 17:16:39 2022 UTC
gpgv:                using RSA key 871920D1991BC93C
```

Here, the key for Ubuntu is `871920D1991BC93C`, so run `gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys 871920D1991BC93C`. This should download and import the key into your keyring for Aptly to use.

2. Update & Publish Mirrors
    - After mirrors are created, you need to create snapshots. Use `update-publish-snapshots.sh` with the mirrors you want to update.
    - Syntax is `bash update-publish-snapshots.sh jammy-main jammy-updates jammy-ansible` for example. 
    - This should download mirrors of these mirrors, then publish them so that your client devices can use them.



3. Serve the Mirrored Repos
TBD


TODO: 
- Finish Publish part of the script.
- Initial GPG setup
- Handling of GPG keys for new mirrors
- Github Actions for Dockerfile
- Systemd Unit
