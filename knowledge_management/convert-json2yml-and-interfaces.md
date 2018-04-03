# Convert yml to JSON and get interfaces

This document gathers the process followed to migrate our kubernetes infrastructure .yml files to json files.

## Tools

Two tools are going to be used:

- json-ts: npm install -g json-ts
- yamljs: npm install -g yamljs

## Scripts

Assuming that we are on the directory where your yml files are located we will run some bash scripts.

First of all we are going to process multidoc files

``` (bash)
rm -rf kube-files
mkdir kube-files
for file in *.yml ; do
  BASENAME=$(basename $file .yml)
  CURRENT_PATH="kube-files/$BASENAME"
  mkdir $CURRENT_PATH

  KUBE_FILES=($(cat $file| grep "kind" | cut -f2 -d : | sed -e "s/\s//g" | tr '[:upper:]' '[:lower:]'))

  if [[ "$(head -n 1 $file)" == "---" ]]; then
    INDEX=0
  else
    INDEX=1
  fi

  while IFS='' read -r line || [[ -n "$line" ]]; do
    if [[ $line == "---" ]]; then
      ((INDEX++))
    else
      echo $line >> "$CURRENT_PATH/${KUBE_FILES[INDEX]}.yml"
    fi
  done < "$file"
done
```

After that we are going to get all the JSON files from our yml files

``` (bash)
yaml2json kube-files --pretty --save --recursive
```

Finally we are going to extract the ts interfaces of our newly created json files

``` (bash)
for file in kube-files/**/*.json ; do
    file | json-ts $file > "kube-files/$(basename "$file" .json).d.ts"
done
```

If you don't need the generated yml files you can delete them using the following command:

```(bash)
for file in kube-files/**/*.yml ; do
  rm $file
done
```
