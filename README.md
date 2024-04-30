# dotfiles

Manage your dotfiles across multiple diverse machines, securely using [Chezmoi](https://chezmoi.io).

### Run

```shell
export GITHUB_USERNAME=renierG
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```


### Update

```shell
chezmoi update
```