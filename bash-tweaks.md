# Fish-ify Bash!

I love the Fish shell (and oh-my-fish) because of four awesome features:

1. The auto-suggestion feature
2. The color highlighting of commands
3. The themes
4. The ability to define custom functions and aliases in separate files

Unfortunately, fish is not the default shell for programming, so sometimes I am forced to switch back to the Bourne Again Shell (BASH) and these missing features.

After doing some research, it turns out that bash too can be made better by making a few tweaks. It does not reach the same level of fish, but it gets close enough for it to be enjoyable to use.


## Install Bash-It

Follow the instructions at [this link](https://github.com/Bash-it/bash-it).

## Change theme

Open the /home/$USER/.bashrc file and locate the line with `export BASH_IT_THEME=`. Replace the entire line with:

```shell
export BASH_IT_THEME='bira'
```

This enables my favorite theme from oh my fish: Bira

## Enable fzf

Run the following command:

```shell
bash-it enable plugin fzf
```

## Replace Readline

This allows for auto suggestions and can be done as follows:

```shell
curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf -
mkdir -p ~/.local/share/blesh
cp -Rf ble-nightly/* ~/.local/share/blesh/
rm -rf ble-nightly
echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bashrc
```

The above instructions are taken from [here](https://github.com/akinomyoga/ble.sh)

Restart bash, and now you'll see auto-suggestions and coloring of commands, on top of the awesome bira theme. Enjoy!