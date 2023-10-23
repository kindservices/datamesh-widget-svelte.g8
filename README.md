# About

The premise of the data-mesh is that it would be cheap and easy to create small, single-purpose widgets.

This template is an attempt to deliver on that promise. In a matter of seconds or minutes, somebody could:

1) use this template to bootstrap a new svelte widget
2) create a corresponding dockerhub repository
2) push their new widget to a new github repository which then publishes to dockerhub

This is possible within any organisation such as Kind which has organisation-level authorisation for github to push to dockerhub.

## Setting up
To create this template, we followed the instructions on [foundweekends.org/giter8](https://www.foundweekends.org/giter8/setup.html), which were to:

1. Install [coursier](https://get-coursier.io/docs/cli-installation#macos-brew-based-installation)
```bash
brew install coursier/formulas/coursier
cs setup
```

2. Use coursier to set up giter8:
 ```base
cs install giter8 
cs update g8
which g8 && echo "g8 installed 👍"
```

# Developing

The template variables go in [default.properties](./src/main/g8/default.properties).

You can read about formatting the templates [here](https://www.foundweekends.org/giter8/formatting.html), e.g. 

```
$name;format="Camel"$
```

# Testing

With `g8` installed, we can test locally like this:
```
g8 file://. --name=uftest --force -o tmp-test
```