# Craft CMS Manager

Craft CMS is an excellent content management tool, but its configuration and setup can be a bit troublesome for those not familiar with PHP.
It's the main reason `craftman` arise, to help speed set up and start a new Craft CMS installation smoothly.

## Installation

First you'll need to make sure your system has git, docker and docker-compose. 

Note: `craftman` does not support Windows.

### Install script

To install or update craftman, you can use the [install script][2] using cURL:

    curl -o- https://raw.githubusercontent.com/gabrielmoreira/craftman/master/craftman_install | sh

or Wget:

    wget -qO- https://raw.githubusercontent.com/gabrielmoreira/craftman/master/craftman_install | sh

<sub>The script clones the craftman repository to `~/.craftman/bin` and adds the source line to your profile (`~/.bash_profile`, `~/.zshrc` or `~/.profile`).</sub>

You can customize the install source, directory and profile using the `CRAFTMAN_DIR`, and `PROFILE` variables.
Eg: `curl ... | CRAFTMAN_DIR="path/to/craftman" sh`

## Usage

 Output from `craftman -h`:
 
    Craft CMS manager
    
    Usage: craftman [options] <COMMAND> [args]
    
    Commands:
     craftman install               Install Craft CMS in current directory
     craftman open                  Open Craft CMS public site
     craftman admin                 Open Craft CMS admin dashboard
     craftman start                 Start Craft CMS docker containers
     craftman stop                  Stop Craft CMS docker containers
     craftman status                Check Craft CMS docker containers status
     craftman ip                    Show Craft CMS docker container IP address
     craftman run                   Open bash or run a command on Craft docker container
     craftman regenerate            Regenerate all craftman configuration files
     craftman reconfigure           Run /home/gabriel/Projetos/Gabriel/craftman/scripts/configure
     craftman copy                  Copy and overwrite scripts/root_files/**/* to
                                    Craft container's root / with recursive directories
    
     craftman mysql:run             Open mysql client or run a command on MySQL docker container
     craftman mysql:backup          Create a backup at backups/
     craftman mysql:restore <file>  Restore a backup from <file> (.sql.gz) to MySQL database
    
     craftman heroku:prepare        Generate required files to deploy to Heroku
    
     craftman composer:lock         Regenerate composer.lock for your composer.json file
     craftman composer:prepare      Generate initial composer.json
    
     craftman --upgrade             Upgrade Craftman
    
    Options:
     -h, --help
     -P, --port            HTTP port to expose on host
    
     -F, --force-all       Force redownload Craft CMS, regenerate and overwrite configurations and recreate containers
     -D, --force-download  Force to download latest Craft CMS from site
     -O, --force-overwrite Force to overwrite generated configuration files at app/ and scripts/ directories
     -R, --force-recreate  Force to recreate containers


If you want to develop locally a new site using Craft CMS:

    mkdir mysite && cd mysite

    craftman --port=8080 install

If you want to deploy on heroku:

    craftman heroku:prepare

    # commit your files, and then:

    heroku create -r
    heroku addons:create cleardb:ignite
    git push heroku
    heroku open

How to access craft container terminal?

    craftman craft:run

You can also access mysql container running:

    craftman craft:mysql

If you need make a mysql backup, run it:

    craftman craft:backup

If you want restore a mysql backup, run it:

    craftman craft:backup BACKUP_FILE_NAME


## License

craftman is released under the MIT license.


Copyright (C) 2016 Gabriel Moreira

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


## Problems

If you try to install craft and the installation fails, you might get an error when trying to reinstall them again or you might get an error like the following:

    file not found

You can try force `-F` to redownload craft, regenerate configurations e recreate containers, using:

    craftman -F -P=8080 install
