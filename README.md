# Craft CMS Manager

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
Eg: `curl ... | CRAFTMAN_DIR="path/to/nvm" sh`


## Usage

If you want install craft, first create an empty directory and then run it:

    craftman --port=8080 install

Wait installation and then you can access

    http://localhost:8080

You can also access craft container bash running:

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

You can try force recreation of containers `-R` and force overwrite files `-O`, using:

    craftman -R -O -P=8080 install
