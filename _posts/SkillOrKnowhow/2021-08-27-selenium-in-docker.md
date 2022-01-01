---
layout: post
title: Python Selenium in Docker
categories: SkillOrKnowhow
tags: [python, selenium, docker]
---

## Reference Links

- [Using Selenium With Python in a Docker Container](<https://dev.to/nazliander/using-selenium-within-a-docker-container-ghp>){:target="_blank"} A blog on dev.to that intruduce a docker file to build containers in which the selenium and chrome run.
- [GitHub: docker-python-chromedriver](<https://github.com/joyzoursky/docker-python-chromedriver>){:target="_blank"} GitHub containing docker files with various versions of python. Seems to based on the source code from the above dev.to blog.
- [A recipe for website automated tests with Python Selenium & Headless Chrome in Docker](<https://www.freecodecamp.org/news/a-recipe-for-website-automated-tests-with-python-selenium-headless-chrome-in-docker-8d344a97afb5/>){:target="_blank"} A blog on freecodecamp written by Joyz who is the author of the github above.


## Sample Source Codes

### Dockerfile

```Dockerfile
# FROM python:3.9
FROM continuumio/anaconda3
RUN apt-get --allow-releaseinfo-change update
RUN apt-get -y update && apt-get install -y gnupg2

# Adding trusting keys to apt for repositories
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
# RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

# Adding Google Chrome to the repositories
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'


# RUN apt-get update && apt-get install -q -y --no-install-recommends \
#     fonts-liberation libasound2 libatk-bridge2.0-0 libatk1.0-0 \
#     libatspi2.0-0 libcairo2 libcups2 libdbus-1-3 libdrm2 libgbm1 \
#     libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libxcomposite1 libxdamage1 \
#     libxfixes3 libxkbcommon0 libxrandr2 libxshmfence1 xdg-utils\
#     && rm -rf /var/lib/apt/lists/
# RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# Updating apt to see and install Google Chrome
RUN apt-get -y update

# Magic happens
# RUN dpkg -i google-chrome-stable_current_amd64.deb
RUN apt-get install -y google-chrome-stable

# Installing Unzip
RUN apt-get install -yqq unzip

# Download the Chrome Driver
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip

# Unzip the Chrome Driver into /usr/local/bin directory
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

# Set display port as an environment variable to avoid crash
ENV DISPLAY=:99

# upgrade pip
RUN pip install --upgrade pip

# install selenium
RUN pip install selenium
# RUN pip install -r requirements.txt

# COPY . /app
# WORKDIR /app

# CMD ["python", "./app.py"]
```

### devcontainer.json

```json
{
	"name": "Python-Selenium",
	// "image": "coolwindjo/anaconda3",

	// Use 'forwardPorts' to make a list of ports inside the container available locally.
	"forwardPorts": [8888],

	"build": {
		"dockerfile": "Dockerfile",
		// "context": "..",
		// Update 'VARIANT' to pick a Python version. Rebuild the container
		// if it already exists to update. Available variants: 3, 3.6, 3.7, 3.8
		// "args": { "VARIANT": "3" }
	},

	// Set *default* container specific settings.json values on container create.
	"runArgs": [
		"--rm",
		// "-p 4445:4444",
		"--net=host",
		"--privileged",
		"--env", "DISPLAY=${env:DISPLAY}",
        "--env", "QT_X11_NO_MITSHM=1",
        "--volume=/tmp/.X11-unix:/tmp/.X11-unix:ro",
        // "--cap-add=SYS_PTRACE",
        // "--security-opt", "seccomp=unconfined",
        // "--volume=/run/user/${env:USER_UID}/pulse:/run/user/1000/pulse",
        // "--group-add=plugdev",
        // "--group-add=video",
		// "--volume=/dev/shm:/dev/shm",
		"--name=python-selenuim"
	],
	"settings": {
		"terminal.integrated.shell.linux": "/bin/bash",
		"python.pythonPath": "/opt/conda/bin/python",
		"python.linting.enabled": true,
		"python.linting.pylintEnabled": true,
		"python.formatting.autopep8Path": "/opt/conda/bin/autopep8",
		"python.formatting.blackPath": "/opt/conda/bin/black",
		"python.formatting.yapfPath": "/opt/conda/bin/yapf",
		"python.linting.banditPath": "/opt/conda/bin/bandit",
		"python.linting.flake8Path": "/opt/conda/bin/flake8",
		"python.linting.mypyPath": "/opt/conda/bin/mypy",
		"python.linting.pycodestylePath": "/opt/conda/bin/pycodestyle",
		"python.linting.pydocstylePath": "/opt/conda/bin/pydocstyle",
		"python.linting.pylintPath": "/opt/conda/bin/pylint"
	},

	// Add the IDs of extensions you want installed when the container is created.
	"extensions": [
		"ms-python.python"
	]

	// Use 'postCreateCommand' to run commands after the container is created.
	// "postCreateCommand": "pip3 install --user -r requirements.txt",

	// Uncomment to connect as a non-root user. See https://aka.ms/vscode-remote/containers/non-root.
}
```


### unit_test.py

```python
import unittest
from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException

class TestTemplate(unittest.TestCase):
    """Include test cases on a given url"""

    def setUp(self):
        """Start web driver"""
        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_argument('--no-sandbox')
        # chrome_options.add_argument('--headless')     # enable if don't want to show the gui
        chrome_options.add_argument('--disable-gpu')
        chrome_options.add_argument('--disable-dev-shm-usage')
        chrome_options.add_argument("--window-size=1920,1080")
        self.driver = webdriver.Chrome(options=chrome_options)
        self.driver.implicitly_wait(10)

    def tearDown(self):
        """Stop web driver"""
        self.driver.quit()

    def test_case_1(self):
        """Find and click top-left logo button"""
        try:
            self.driver.get('https://www.oursky.com/')
            el = self.driver.find_element_by_class_name('header__logo')
            el.click()
        except NoSuchElementException as ex:
            self.fail(ex.msg)

    def test_case_2(self):
        """Find and click top-right Start your project button"""
        try:
            self.driver.get('https://www.oursky.com/')
            el = self.driver.find_element_by_class_name("header__cta")
            el.click()
        except NoSuchElementException as ex:
            self.fail(ex.msg)

if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(TestTemplate)
    unittest.TextTestRunner(verbosity=2).run(suite)
```