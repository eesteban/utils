# Databases

## MongoDB

### Articles

- [How to Install and Secure MongoDB 3.6 on Ubuntu 17.10](https://medium.com/gatemill/how-to-install-mongodb-3-6-on-ubuntu-17-10-ac0bc225e648)

### Snippets

Working with deep arrays on Mongo:

```(js)
db.getCollection('bundle').update(
  {
    _id: ObjectId("5ac33311247f4573621b90fe")
  },
  {
    $set: {
      "kubes.$[kube].modifications.$[modification]": {
        "expression" : "$.spec.template.spec.containers[0].env[2]",
        "currentValue" : {
          "name" : "DEBUG",
          "value" : "false"
        },
        "previousValues" : [
          {
            "overwrittenAt" : "",
            "value" : {
              "name" : "DEBUG",
              "value" : "false"
            }
          }
        ]
      }
    }
  },
  {
    multi: true,
    arrayFilters: [
      {
        "kube.id" : "99c9f670-9564-4610-9d48-1ffe74fe6a33"
      },
      {
        "modification.expression" : "$.spec.template.spec.containers[0].env[2]"
      }
    ]
  }
)
```
