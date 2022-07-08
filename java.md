
# Setup Java Environment

## SDKMan

SDKMan is like nvm for Java.
It lets you install and switch between different Java versions easily.

### install

```bash
curl -s "https://get.sdkman.io" | bash
```

### select version

```bash
sdk ls java                       # list available java versions
sdk install java 17.0.3.6.1-amzn  # install a specific java version
sdk default java 17.0.3.6.1-amzn  # set java version as default
java --version                    # check correct java version is used
```

## Maven

```bash
./mvwn          # download and install maven
./mvwn install  # download and install dependencies
```

