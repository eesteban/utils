# Scripts

## Take it

You did a PR and you need to ammend it? It's easy, just update your files and execute `take-it`

It will add all the current modifications, ammend the previous commit and push it to the repo.

It won't work on **master** branch

## Link it

When you need to add something to your path `link-it [full-path]`

It will check if there isn't already a symlink, if it doesn't exist it will create a link to the specified path

## Fix assets

When you need to fix your assets `fix-assets [relative-path]`

It will check all the folders on the given path and, making the assumption that every directory on the path is an asset, will reset the last n commits that correspond to some of the assets `xxxxx(asset_name): nnnn` and then redo the commits in the same order adding all the modified files to each asset on the given commit.

## Kube redeploy

When you need to redeploy a kube `kube-redeploy [kube_namespace] [kube_file]`

It will execute `kubectl create ...` and `kubectl delete ...` for the given file on the given namespace

## Kube rdp git

When you need to redeploy a kube `kube-rdp-git [kube_namespace]`

It will execute `kube-redeploy` for all the files that differ from origin on the current repo folder

## Who is in port

When you need to check the process on a given port `wport [port]`
